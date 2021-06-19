#1/bin/bash
grep '-' 0310_win_loss_player_data > 0310_Players.txt
grep '-' 0312_win_loss_player_data > 0312_Players.txt
grep '-' 0315_win_loss_player_data > 0315_Players.txt

cat 0310_Players.txt 0312_players.txt 0315_Players.txt > Players_Playing_during_losses.txt

awk -F" " '{print $1, $2, $5, $6}' 0310_Dealer_schedule > 0310_Dealer.txt
awk -F" " '{print $1, $2, $5, $6}' 0312_Dealer_schedule > 0312_Dealer.txt
awk -F" " '{print $1, $2, $5, $6}' 0315_Dealer_schedule > 0315_Dealer.txt

cat 0310_Dealer.txt 0312_Dealers.txt 0315_Dealer.txt > Dealers_working_during_losses.txt

cat Players_Playing_during_losses.txt Dealers_working_during_losses.txt > Dealers_Players.txt







