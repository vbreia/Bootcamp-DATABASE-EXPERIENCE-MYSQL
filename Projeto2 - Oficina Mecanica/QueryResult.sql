use oficina;

-- Resgatando dadps do funcionário equope e especialidade
SELECT f.idFuncionario, f.Nome, f.Especialidade, e.Descricao 
FROM funcionario f
	INNER JOIN equipe e ON e.idEquipe = f.IdEquipe
	WHERE f.IdEquipe = 2;

-- Resgatando dados dos funcionários com especialidade 'mecanico'
SELECT * from funcionario f
	WHERE f.Especialidade = 'MECANICO';
    
-- Resgatando dados do carro e ordem de serviço
SELECT c.Marca, c.Placa, os.idOrdem_Servico, os.DataConclusao, os.Status, p.idPecas, p.Descricao, pu.Qtd, p.Valor 
FROM ordem_servico os 
	INNER JOIN pecasutilizadas pu ON os.idOrdem_Servico = pu.IdOS
	INNER JOIN pecas p ON p.idPecas = pu.IdPecas
	INNER JOIN carro c ON c.idCarro = os.idCarro;

-- Resgatando dados do carro e status do serviço
Select c.Marca, c.Placa, os.idOrdem_Servico, os.DataConclusao, os.Status, s.idServicos, s.Descricao, s.Valor 
FROM ordem_servico os 
	INNER JOIN servicorealizado sr ON os.idOrdem_Servico = sr.IdOS
	INNER JOIN servicos s ON sr.IdServico = s.idServicos
	INNER JOIN carro c ON c.idCarro = os.idCarro;



