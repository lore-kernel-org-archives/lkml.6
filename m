Return-Path: <outreachy-kernel+bncBDZJXP7F6YLRB5OX5LKAKGQESGT2NZY@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520086006; cv=pass;
        d=google.com; s=arc-20160816;
        b=HrKY9aWJEVZOCHq/odThdz0kKcO1QZOa36bU36ZhxDJCEZHySoGqq5u/lM5lZrFVHX
         29MXxsXSqi+M4uNWBFyQunQKdaq1BN3+g3XaWb6NYNdopYLqV/p/vpbnC+hS8Aat3IFy
         O3wcWoKGteM72HXWJr0U/FpyoH0TjJJzNPjbsQdOknByqSEMOAMS2egdnqpsRqG69ZzC
         tN1H+yhaoWFJsK3eST0wzf9ZldqxmfNgdV8QEIo9guiNBV7c8JVqrzNDzAhYJGp0A+WA
         bKcmFEgEvIJHD4YYQwIuoNx76KQ9VVT94io9FHZtjzU7Bqm1APJGDdbz8UqNZkxFb3EX
         g/Bg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=ZU+Wtj2jgyHNlSY7FEQiBNuE7Flb09cUQioBff2S2UM=;
        b=xq41aJVgFCPEBZi1+TJDrQySjdqRxLbAlP7A1/iH8FxWskIg2ObGWKIBx6gv01bSWG
         y6Rm7YqAiFCcMi+/4LjW0jvDs/Cuwgikz0wLwYRbqkX4PJNvY731psYLC/jfDPQhBFHW
         GSe3EtsWdeiBIV+slBqMo3vMd4NSzJ4EimxCcABDB+v4/eWMEy/5uyZSy06QXuYsvAD8
         dw0mSE3AUSQT0PQiAwBF7VV0ZkPMiRtirclQy8wbwdzWQh+JOoLlCVt604Pgr0w6lAdG
         3kVqTHCLVfc/w2NJx35yESa6lXhjh8YWkwsLOEkPn9ZOv8bd2HcJbizo98+MCNbQnI8r
         J5OQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=cytdvgjq;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbdzjxp7f6ylrb5ox5lkakgqesgt2nzy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDZJXP7F6YLRB5OX5LKAKGQESGT2NZY@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=cytdvgjq;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbdzjxp7f6ylrb5ox5lkakgqesgt2nzy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDZJXP7F6YLRB5OX5LKAKGQESGT2NZY@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1520086006; cv=pass;
        d=google.com; s=arc-20160816;
        b=WjuLL0wcgVznZ6mgTJK5IZpbJJ724mCk+2jWyjn+6Os+Hp/+4RA+fFWzfZLpECu+O1
         ysNbyRRhgDsBsRGg4/hDpIJZrcmXbRScWIOmNTwEeTjcA2FUs13Iax/u87cBTMCW/gnF
         8LMBIEdgmOfFv7iB+Xq7oLaiDywQdwxzhQMjz/xYBeRt+a3EeWj5gYBhOZDfFvEOvH2J
         7DtTwz/q/tpExgTSbfcFUmJtwkPQXUmaGPz0RQNmH21pUaWBB/npajdfxVlUwTzsD1Hi
         QoQ6edj6JAL2nsnJaLwQksb5mpg5/eWE02YFsGFRFWV7+h8QhTT8SJWdj2d+vB9qV/Um
         0k6A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=ZU+Wtj2jgyHNlSY7FEQiBNuE7Flb09cUQioBff2S2UM=;
        b=LHOjadu6kuzCHlI0SGP/0SbDpss1mxU3UHRaDbGx+pN+oPfpoXMrd8mQqJVgMKbbb3
         pWLDQ7RezknCvhvqXUSZwzHzsFidOMBB7O72tmbSlGU4ro0nTYFqXEwkdcb4ldqGw2LM
         mTB1kWC9VHgIV/UdebTD7jhh7GpYW8cfGa5l8Wi+aTc5Wdgj7gfUmMzJMKiZAT47Wc+k
         aeEzx7vyM/QKOu40GPfecqqijaO59neYqiUFscYbvMv6B7R3ta8Q4G5NRpvF+LC90yC6
         ER0bQ08GxM5+d0xsRjqQ/qP9FdTdrcgE2B8U/dUKFnna3PSPS17Fap8KFizygiBGecaU
         8MsQ==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=neutral (google.com: 192.134.164.104 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELueZwlauNHuuzvFhEBQxd3elPxy4ITSrTDbXNJY1IJof3RZGr5LBosJkBjaN8spqSIrIHN/jw==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520086005; cv=none;
        d=google.com; s=arc-20160816;
        b=uNM5S/NdZV0t/xp/jfu7Is8yuA9tVMU3AoF0njJS9DsKEEIihTttOMAiIFCXF8TvnY
         x0i8AhJwiNoAEum4JTY94TAHI6MRuNlaif8X83UaQOfTiUji6fZxdf+azgmC/bTTBgpq
         zXjl7Rp+o+XGJ7SDvtICtVET3zAIhfhEVJSVZf0c6jpJDwjg2eAUKAwAeftnsL3wHPxv
         Vj2XLZVlwZRcmyG1QNxorTvioDwsjxfI2TQ7Pw8GpdxfvxSYGK8iM+jViMTxucz13q82
         0sF3o58ZvTfBmVUEVCz1OE2YOEyUhxSC1OKe5SgVCbaHBvLT0xfUAtippb+girFUNczm
         9LJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=jf9PoqmnrMjf3WPhUOKHYPIpP6z25xc8xIB3dLSJQBk=;
        b=J62md3XaM/dIYMdR+8IoNZOSY63jARXKlVyxualw1mEQ/OekEzuVahcc3HrQNrLTGL
         Boiq7VfFMiR799v+Lajl7lEQGIe7pyWVAyXhCZjnE4kQx1ucZKuZJMDcJX28wDWdb+6H
         PEdaalCw0y96+4nioR7ADjl9Uf61AogrPTmbKl0YIe0n6g93AWj89fH7j3fAOwOJsebr
         BPfV/IpM/6psCsevkddDWBxijkzUTVC1kw16tb8usHn6mCOp85jXaFtIbKdVJA4eQTv8
         OxJinB9Y+To0njFkBIJJcdAqLgbVW/4ldbtU5v1fdqAMAAUd1UZaiGP1pKHJ/OQ/CLxS
         YrUQ==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=neutral (google.com: 192.134.164.104 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
X-IronPort-AV: E=Sophos;i="5.47,418,1515452400";
   d="scan'208";a="256828672"
Date: Sat, 3 Mar 2018 15:06:43 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
cc: jdmason@kudzu.us, Jakub Kicinski <jakub.kicinski@netronome.com>,
    netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
    oss-drivers@netronome.com, outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] net: ethernet: Drop unnecessary continue
In-Reply-To: <20180303130933.GA8337@seema-Inspiron-15-3567>
Message-ID: <alpine.DEB.2.20.1803031506060.2302@hadrien>
References: <20180303130933.GA8337@seema-Inspiron-15-3567>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Original-Sender: julia.lawall@lip6.fr
X-Original-Authentication-Results: gmr-mx.google.com;       spf=neutral
 (google.com: 192.134.164.104 is neither permitted nor denied by domain of
 julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Spam-Checked-In-Group: outreachy-kernel@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593922138604238925?=
X-GMAIL-MSGID: =?utf-8?q?1593925705021849077?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Sat, 3 Mar 2018, Arushi Singhal wrote:

> Continue at the bottom of a loop are removed.
> Issue found using drop_continue.cocci Coccinelle script.

In each case you leave an if with a single statement in the branch.  In
that case the { } should be dropped too.

julia

>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/net/ethernet/amd/ni65.c                   | 1 -
>  drivers/net/ethernet/neterion/s2io.c              | 1 -
>  drivers/net/ethernet/netronome/nfp/nfp_net_main.c | 1 -
>  3 files changed, 3 deletions(-)
>
> diff --git a/drivers/net/ethernet/amd/ni65.c b/drivers/net/ethernet/amd/ni65.c
> index e248d1a..5975f29 100644
> --- a/drivers/net/ethernet/amd/ni65.c
> +++ b/drivers/net/ethernet/amd/ni65.c
> @@ -437,7 +437,6 @@ static int __init ni65_probe1(struct net_device *dev,int ioaddr)
>  			for(j=0;j<3;j++)
>  				if(inb(ioaddr+cards[i].addr_offset+j) != cards[i].vendor_id[j]) {
>  					release_region(ioaddr, cards[i].total_size);
> -					continue;
>  			  }
>  		}
>  		break;
> diff --git a/drivers/net/ethernet/neterion/s2io.c b/drivers/net/ethernet/neterion/s2io.c
> index b8983e7..5123abd 100644
> --- a/drivers/net/ethernet/neterion/s2io.c
> +++ b/drivers/net/ethernet/neterion/s2io.c
> @@ -3682,7 +3682,6 @@ static void restore_xmsi_data(struct s2io_nic *nic)
>  		if (wait_for_msix_trans(nic, msix_index)) {
>  			DBG_PRINT(ERR_DBG, "%s: index: %d failed\n",
>  				  __func__, msix_index);
> -			continue;
>  		}
>  	}
>  }
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
> index 15fa47f..77916ed 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
> @@ -260,7 +260,6 @@ nfp_net_pf_alloc_vnics(struct nfp_pf *pf, void __iomem *ctrl_bar,
>  		/* Kill the vNIC if app init marked it as invalid */
>  		if (nn->port && nn->port->type == NFP_PORT_INVALID) {
>  			nfp_net_pf_free_vnic(pf, nn);
> -			continue;
>  		}
>  	}
>
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180303130933.GA8337%40seema-Inspiron-15-3567.
> For more options, visit https://groups.google.com/d/optout.
>

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/alpine.DEB.2.20.1803031506060.2302%40hadrien.
For more options, visit https://groups.google.com/d/optout.
