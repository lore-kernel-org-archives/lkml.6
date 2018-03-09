Date: Fri, 9 Mar 2018 10:58:13 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bich HEMON <bich.hemon@st.com>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre TORGUE <alexandre.torgue@st.com>,
	Jiri Slaby <jslaby@suse.com>,
	"linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: serial: stm32: add RS485 optional
 properties
Message-ID: <20180309185813.GA25626@kroah.com>
References: <1519815373-22940-1-git-send-email-bich.hemon@st.com>
 <1519815373-22940-2-git-send-email-bich.hemon@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519815373-22940-2-git-send-email-bich.hemon@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 10:56:18AM +0000, Bich HEMON wrote:
> Add options for enabling RS485 hardware control and configuring
> Driver Enable signal:
> - rs485-rts-delay
> - rs485-rx-during-tx
> - rs485-rts-active-low
> - linux,rs485-enabled-at-boot-time
> 
> Signed-off-by: Bich Hemon <bich.hemon@st.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/serial/st,stm32-usart.txt | 2 ++
>  1 file changed, 2 insertions(+)

This series does not apply to my tty-next tree at all.  Can you rebase
and resend?

thanks,

greg k-h
