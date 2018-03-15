Date: Thu, 15 Mar 2018 18:34:03 +0100
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bich HEMON <bich.hemon@st.com>
Subject: Re: linux-next: build warnings after merge of the tty tree
Message-ID: <20180315173403.GA29986@kroah.com>
References: <20180315174331.6c7b600b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315174331.6c7b600b@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 15, 2018 at 05:43:31PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> After merging the tty tree, today's linux-next build (arm
> multi_v7_defconfig) produced these warnings:
> 
> drivers/tty/serial/stm32-usart.c:155:12: warning: 'stm32_init_rs485' defined but not used [-Wunused-function]
>  static int stm32_init_rs485(struct uart_port *port,
>             ^~~~~~~~~~~~~~~~
> drivers/tty/serial/stm32-usart.c:100:12: warning: 'stm32_config_rs485' defined but not used [-Wunused-function]
>  static int stm32_config_rs485(struct uart_port *port,
>             ^~~~~~~~~~~~~~~~~~
> 
> Introduced by commit
> 
>   1bcda09d2910 ("serial: stm32: add support for RS485 hardware control mode")

Fix for this just hit my tree, thanks for the notice.

greg k-h
