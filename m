Return-Path: <julia.lawall@lip6.fr>
X-Google-Smtp-Source: AG47ELvvO1nX+UDnt/SintsdSRroZiE4ApUwMFh0o1vCGpmrVu2d9zYWamQFR2hoB7nZKUtPNGXb
ARC-Seal: i=1; a=rsa-sha256; t=1520110362; cv=none;
        d=google.com; s=arc-20160816;
        b=bTPzSWNB0KvNHM4Lf24mGRwZOSsm+aDMRYDDCLUVzQR/9gmYOKJri5xMok1r+NW7+g
         BqSt9r0LdavGMnIZJZIMVQ96EjCXXKbv1jKe7U10/wVZJ5sIiUTB5mTI5QLQpxEmiZrz
         mZ4d3KCDgcHSc8rP+qE1OwXDcY1LPiYkF96XznFcxZaEybkhDDn5oDcC/Eii+Nub0xxK
         LzTDNWAjnH6sWxEL0T69l6X2Fc//0Y4z7KH/c2JjXUL1uAw96f2HhAYOsHvUuAzuVpnk
         /UQ0qj2ZBeSRhG0xc+WZDvcpiqRqwf5wxzW3Im4sh7lqVYrxu49LVaINHXof6AI2cwm4
         D/0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=zdmsXkYGCHB8/db6iyjow5zIFnkKdzuTERHdjEKliPE=;
        b=p4Dxh5vAOE3AWH7d/ECwHW36BF0pMXIy8On+wjQQjVtGXAtA4JZACYcfbDMdaBkILd
         ueOGUMIyDFd22iihB+sqb7K79Zr7WAL/36tDKOLZVWr1ixrKMRuOjq7j6lYMx5gD5L4L
         iXGctFxnbX4jRqm1KGCENuCHvonvR1dSzaQAc9CEKYludMsQ7CFf9w1vacdmH+UQqS5X
         jRAwHtdYigtpCpC+h6D2nc8iCzmGZCqPCdVlzUujymZFCGg9eXxcJWjHf2iC7RPTdadh
         Je/LQHje8uiVs4hp4XR59dLvzRbVVwk35Z/MDrjH3D3H0k6L8z6RcOTAZBEXTYxkm4qO
         mM2A==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
X-IronPort-AV: E=Sophos;i="5.47,419,1515452400";
   d="scan'208";a="316240577"
Date: Sat, 3 Mar 2018 21:52:41 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
cc: gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
    linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] staging: rtl8723bs: Remove unnecessary
 semicolon.
In-Reply-To: <20180303191726.GA4986@seema-Inspiron-15-3567>
Message-ID: <alpine.DEB.2.20.1803032152260.9544@hadrien>
References: <20180303191726.GA4986@seema-Inspiron-15-3567>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593945276088463100?=
X-GMAIL-MSGID: =?utf-8?q?1593951243280959167?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Sun, 4 Mar 2018, Arushi Singhal wrote:

> Remove unnecessary semicolon using semicolon.cocci Coccinelle script.
>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  drivers/staging/rtl8723bs/core/rtw_recv.c       | 2 +-
>  drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
> index 9c7c3be..86f995b 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_recv.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
> @@ -1785,7 +1785,7 @@ static union recv_frame *recvframe_defrag(struct adapter *adapter,
>  		pfhdr->attrib.icv_len = pnfhdr->attrib.icv_len;
>  		plist = get_next(plist);
>
> -	};
> +	}
>
>  	/* free the defrag_q queue and return the prframe */
>  	rtw_free_recvframe_queue(defrag_q, pfree_recv_queue);
> diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
> index a71b552..f6aeb26 100644
> --- a/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
> +++ b/drivers/staging/rtl8723bs/hal/rtl8723b_rf6052.c
> @@ -163,7 +163,7 @@ static int phy_RF6052_Config_ParaFile(struct adapter *Adapter)
>  			break;
>  		}
>
> -		/*----Restore RFENV control type----*/;
> +		/*----Restore RFENV control type----*/
>  		switch (eRFPath) {
>  		case RF_PATH_A:
>  		case RF_PATH_C:
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180303191726.GA4986%40seema-Inspiron-15-3567.
> For more options, visit https://groups.google.com/d/optout.
>
