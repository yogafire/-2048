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
    board[row][column]= value
  else
    generateTile(board)

  console.log "generate tile"

showBoard = (board) ->
  for row in [0..3]
    for col in [0..3]
      $(".r#{row}.c#{col} > div").html(board[row][col]
  console.log "show board"
printArray = (array) ->
  console.log "-- Start --"
  for row in array
    console.log row
  console.log "--  End  --"

$ ->
  newBoard = buildBoard()
  generateTile(newBoard)
  generateTile(newBoard)
  printArray(newBoard)

  $('body').keydown (e) =>
    e.preventDefault()

    key = e.which
    keys = [37..40]

    if keys.indexOf key > -1
      # continue the game
      console.log "key: ", key
      direction = switch key
        when 37 then 'left'
        when 38 then 'up'
        when 39 then 'right'
        when 40 then 'down'
      console.log "direction: ", direction
    else
      # do nothing












