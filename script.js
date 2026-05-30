// Seleção de elementos do Menu Mobile
const mobileMenu = document.getElementById('mobile-menu');
const navLinks = document.querySelector('.nav-links');

// Abrir e fechar menu mobile ao clicar no ícone
mobileMenu.addEventListener('click', () => {
    navLinks.classList.toggle('active');
    
    const icon = mobileMenu.querySelector('i');
    if (navLinks.classList.contains('active')) {
        icon.classList.remove('fa-bars');
        icon.classList.add('fa-xmark');
    } else {
        icon.classList.remove('fa-xmark');
        icon.classList.add('fa-bars');
    }
});

// Fechar o menu ao clicar em qualquer link
document.querySelectorAll('.nav-links a').forEach(link => {
    link.addEventListener('click', () => {
        navLinks.classList.remove('active');
        const icon = mobileMenu.querySelector('i');
        icon.classList.remove('fa-xmark');
        icon.classList.add('fa-bars');
    });
});

// LÓGICA DO BOTÃO DE COPIAR DO TERMINAL
const copyButton = document.getElementById('copy-button');
const cmdText = document.getElementById('cmd-text').innerText;

copyButton.addEventListener('click', () => {
    // Copia o texto para a área de transferência
    navigator.clipboard.writeText(cmdText).then(() => {
        // Altera o ícone para confirmação (check)
        const icon = copyButton.querySelector('i');
        icon.classList.remove('fa-regular', 'fa-copy');
        icon.classList.add('fa-solid', 'fa-check');
        copyButton.style.color = '#4ade80'; // Muda a cor para verde

        // Retorna ao ícone padrão após 2 segundos
        setTimeout(() => {
            icon.classList.remove('fa-solid', 'fa-check');
            icon.classList.add('fa-regular', 'fa-copy');
            copyButton.style.color = ''; // Reseta a cor original
        }, 2000);
    }).catch(err => {
        console.error('Erro ao copiar código: ', err);
    });
});

// Manipulação do envio do formulário de contato
const contactForm = document.getElementById('contact-form');

contactForm.addEventListener('submit', (e) => {
    e.preventDefault();
    const name = contactForm.querySelector('input[type="text"]').value;
    alert(`Obrigado pelo contato, ${name}! A equipe John-Optimizer responderá em breve.`);
    contactForm.reset();
});
