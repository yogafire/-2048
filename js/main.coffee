randomInt = (x) ->
  Math.floor(Math.random() * x)

randomCellIndices = ->
  [randomInt(4), randomInt(4)]

randomValue = ->
  values = [2, 2, 2, 4]
  values[randomInt(4)]

buildBoard = ->
  # board = []
  # for row in [0..3]
  #   board[row] = []
  #   for column in [0..3]
  #     board[row][column] = 0
  # board
  [0..3].map (-> [0..3].map (-> 0))

generateTile = (board) ->
  value = randomValue()
  [row, column] = randomCellIndices()
  console.log "row: #{row} / col: #{column}"

  if board[row][column] is 0
    board[row][column] = value
  else
    console.log 'generate infinitely'
    generateTile(board)

  console.log "generate tile"

move = (board, direction) ->
  newBoard = buildBoard()

  for i in [0..3]
    if direction in ['right', 'left']
    #OR: if direction in ['right', 'left]
      row = getRow(i, board)
      row = mergeCells(row, direction)
      row = collapseCells(row, direction)
      setRow(row, i, newBoard)
    else if direction in ['up', 'down']
      column = getColumn(i, board)
      column = mergeCells(column, direction)
      column = collapseCells(column, direction)
      setColumn(column, i, newBoard)

  newBoard

getRow = (r, board) ->
  [board[r][0], board[r][1], board[r][2], board[r][3]]

getColumn = (c, board) ->
  [board[0][c], board[1][c], board[2][c], board[3][c]]

setRow = (row, index, board) ->
  board[index] = row

setColumn = (column, index, board) ->
  for i in [0..3]
      board[i][index] = column[i]

mergeCells = (cells, direction) ->

  merge = (cells) ->
    for a in [3...0]
      for b in [a-1..0]
        if cells[a] is 0 then break
        else if cells[a] == cells[b]
          cells[a] *= 2
          cells[b] = 0
          break
        else if cells[b] isnt 0 then break
    cells

  if direction in ['right', 'down']
    cells = merge(cells)
  else if direction in ['left', 'up']
    cells = merge(cells.reverse()).reverse()

  cells

# console.log mergeCells [2, 2, 0, 4], 'left'

collapseCells = (cells, direction)->
  # Remove '0'
  cells = cells.filter (x) -> x isnt 0
  # Adding '0'
  while cells.length < 4
    if direction in ['right', 'down']
      cells.unshift 0
    else if direction in ['left', 'up']
      cells.push 0
  cells

#console.log collapseCells [0, 8, 0, 0], 'right'

moveIsValid = (originalBoard, newBoard) ->
  for row in [0..3]
    for col in [0..3]
      if originalBoard[row][col] isnt newBoard[row][col]
        return true

  false

boardIsFull = (board) ->
  for row in board
    if 0 in row
      return false
  true

noValidMoves = (board) ->
  directions = ['right', 'left', 'up', 'down']
  for direction in directions
    newBoard = move(board, direction)
    if moveIsValid(board, newBoard)
      return false
  true

isGameOver = (board) ->
  boardIsFull(board) and noValidMoves(board)

showBoard = (board) ->
  for row in [0..3]
    for col in [0..3]
      if board[row][col] is 0
        $(".r#{row}.c#{col} > div").html('')
      else
        $(".r#{row}.c#{col} > div").html(board[row][col])

printArray = (array) ->
  console.log "-- Start --"
  for row in array
    console.log row
  console.log "--  End  --"

$ ->
  @board = buildBoard()
  generateTile(@board)
  generateTile(@board)
  showBoard(@board)

  $('body').keydown (e) =>

    key = e.which
    keys = [37..40]

    if key in keys
      e.preventDefault()
      console.log "key: ", key
      direction = switch key
        when 37 then 'left'
        when 38 then 'up'
        when 39 then 'right'
        when 40 then 'down'

      # try moving
      newBoard = move(@board, direction)
      printArray @board
      printArray newBoard
      # check the move validity, by comparing the original and new board
      if moveIsValid(@board, newBoard)
        console.log "valid"
        @board = newBoard
        # generate tile
        # show board
        generateTile(newBoard)
        showBoard(@board)
        # check game lost
        if isGameOver(@board)
          alert "YOU LOSE!"
      else
        console.log "invalid"

    else
      #do nothing










