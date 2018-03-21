Date: Wed, 21 Mar 2018 17:24:37 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Vic Wei <vwei@codeaurora.org>
Cc: marcel@holtmann.org, linux-kernel@vger.kernel.org,
	majordomo@vger.kernel.org, stable@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@vger.kernel.org,
	kumo@qti.qualcomm.com, vwei@qti.qualcomm.com
Subject: Re: [PATCH 1/1] Bluetooth: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for
 BTUSB_QCA_ROME
Message-ID: <20180321162437.GB3506@kroah.com>
References: <1521648597-2642-1-git-send-email-vwei@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521648597-2642-1-git-send-email-vwei@codeaurora.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 09:09:57AM -0700, Vic Wei wrote:
> QCA Rome controllers can do both LE scan and BR/EDR inquiry at once.
> 
> Change-Id: I89e1412d635f4cd7b2500f7492f37430ea139f0c

What is this line for?

> Signed-off-by: Vic Wei <vwei@codeaurora.org>
> ---
>  drivers/bluetooth/btusb.c | 1 +
>  1 file changed, 1 insertion(+)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
