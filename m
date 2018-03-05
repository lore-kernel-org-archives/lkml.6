Return-Path: <outreachy-kernel+bncBCWJFEEKWIDRBKOK6PKAKGQEB3FRFYY@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520231721; cv=pass;
        d=google.com; s=arc-20160816;
        b=w/z551GDqATV3pTJHENrhO9HLU1HngBD/UPe8iZsEfUIe757GdymIrAZw81IxokML/
         gPnjJkG/rHc9v4+0sSZz6/J6n5K68AbQqFecFpIgHiT7JhQMw9ByiMJPcqmJNWhKB3ij
         dSGdANMVU93hIQszy21WyUGJvlR98pMI3Sa43AnPGL0lGHhQFOPVpmXazgJhnCt3pB+K
         wamsehowBKW+AiZFndntPeDiO5fbItg8HlYi7BSpw/vbhtLjfxpMBDjB57gIgXimZBOq
         2S/hZpiOcr+ukth2zZwdnUizVOXOAoNUHEVmVTrrHvb5PpdqVmBT3qhDnQzmqUZioIKD
         a32g==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=qjBSaA5BpEwmYOIyqRhNE2ICTYTDQQ/b4mmXR90WY7Q=;
        b=NHAB3kExAxFOKg6ZQQt3lL1S0bWshNeR13Ah+q0JkLOLzJGmA91yC22iIn/I3lWWsX
         aCreqlSbXgdNOq0FRgoSx8E0WV6Twt+o5lWO81motSpkjFkS/7V5TlHNCEpwoEn7fwua
         ve9mLqAw1k+q+zizBS63+2MeqQaTX0nSdXhAbUYUbvp2xXEZ5kZxCqo/i2FCjPetU2QD
         sgcyhiXcMSenXXwHkzs1b2qOgBikJHAo/plI9EPwmMwp94Ys11JOTbBj4oPVtjvyKAbi
         oztahEqDhupCUaGxjqzCPp2sjd/XZ9ijFi4Ou6ivNygtpVAY2zhrw9czNDW9Ts98+j8R
         l5oQ==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=Xy+rBr42;
       arc=pass (i=2 dkim=pass dkdomain=netronome-com.20150623.gappssmtp.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcwjfeekwidrbkok6pkakgqeb3frfyy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCWJFEEKWIDRBKOK6PKAKGQEB3FRFYY@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=Xy+rBr42;
       arc=pass (i=2 dkim=pass dkdomain=netronome-com.20150623.gappssmtp.com);
       spf=pass (google.com: domain of outreachy-kernel+bncbcwjfeekwidrbkok6pkakgqeb3frfyy@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBCWJFEEKWIDRBKOK6PKAKGQEB3FRFYY@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1520231721; cv=pass;
        d=google.com; s=arc-20160816;
        b=DfmquD0pdiyzPhafEvzCl2w/m61avFMz1+MOcaHMIWACo9zdVS8UbPZ8ouWiFeKpNF
         2UMG1P18XLVph2in8kw2kqMeOnUlXbuTN7lsuSZb4kJB0ucyPfy2Y4uQzomOBNSOAJnj
         Y/gvt8jxfEJSz1QY9Jmm57rRfI1v3qx0Ta2Ol4E0PGPKZQRXBx6H9gVSazXy7qfLW9Fp
         n48brCzBKZfxpe3blDQI1AB0zKABYAXTXg4MmTDvCwpzbTAHq79p5k+sbuSW74G9T7cp
         RXQIkP7m1Zf6MGJHy2lh8yu08SdCo2R0b8uUflQlUXlUGsY+jPCi4Z37b0JcpNm6TT/x
         Ro0A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=qjBSaA5BpEwmYOIyqRhNE2ICTYTDQQ/b4mmXR90WY7Q=;
        b=SUXimB80npojgf647hxiFLkiNskx+19/cc0RVotOFN64cBgtht3s3HXD65L8CCCQd2
         +1pQvfdiuHzRBFHsVJMNptpo1ysd4p0s275QTemIWQEtmHtu5tbcEdPHAsvDpRj+bGMe
         WP43FO0mr7fnCxuDiYfPebjKVHoz+V33NgnUZER8Lobmhy+VtG0oy3NdiT3kNqM1TA8A
         6nJyx7dIRzvxwMdQwy5r+fGPgbehVOgn8iEqN7xAec55EeOjnLRhmKpgjZjZXzAHxPTG
         YVIhglNZL7dXQmnTXFRGtOHC7TV3r9PEtwT4O37pNmLFETc40bieuApU7n7D7gkYXqY/
         gCDg==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       dkim=pass header.i=@netronome-com.20150623.gappssmtp.com header.s=20150623 header.b=18TOPH3+;
       spf=neutral (google.com: 2607:f8b0:400d:c09::232 is neither permitted nor denied by best guess record for domain of jakub.kicinski@netronome.com) smtp.mailfrom=jakub.kicinski@netronome.com
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELtRPmog5QVyDv7hokJd40NTF4SB0/4pdhOATP0q2ig6XMoP9BvQFEsVD55H2OZtEAZsIC7aIw==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520215037; cv=none;
        d=google.com; s=arc-20160816;
        b=aSq1+5w8BqT4k2OmxZH7mEbxtKmDQbCNeEiyE6anm75FrxpkLkmCFO++r2L74w9IGI
         6Npjg7uNOx1+aiCr8rAozpd0O8K7asFtyxVH5lJs0JzOmCWmSOdSZrUz2ZQdimeCchrn
         iv8FhgkZ40gjNHut/gfhVY5hC3uRDzDkkQbYWfXn+RLXTjdTB6c36+yWpMyDCxsJAMKA
         0c6V8QHOlcTwOFoXs9s/aUBNdD+Zx3n/kASbiRVGe0nonAQCpl82fIoSmfLG/IRQq7jI
         VbI2a6o4rATg/7AEDUSJBXs18J/4z5YT6rzDEk2aIP4nUSd/el8qYGYl0/KAYWvZnpqA
         Bi+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=BU7RsmZupkUe75oebmaixL8G1y3csUrVmnPrFnpZPao=;
        b=IL/ZFaoIRhjAWGvf7Ig5OX2Z0zclJtPJAU8BusiDvmdUuIbbDDJbLcvyskzeZVT8M2
         aKOiGyNWPxmPoWoq9rlbrjykHWzHGCisMJddD13ejaQ3Qz/iNEG/SKuOjAsViqb++rqX
         eNYU8XEPeusDaBr6j/Q/UZBiwZ8Qu49JLO3nQ3vcBWNDwG+NI/pCzz0uk+YYVhJZmvEr
         JTk7zkUWonm/E6OIYOU1h3Gde3Ws0UKDr/xWbVq/nQbiXJ8GJsklYLLxP55Y2rKN3rur
         K6hmkGt7SN70HJh+kZLDpEuftgm3j3D9KlOqIfiKayPus08Dd7GP//sJce30ppSWtmSK
         Y+Ww==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       dkim=pass header.i=@netronome-com.20150623.gappssmtp.com header.s=20150623 header.b=18TOPH3+;
       spf=neutral (google.com: 2607:f8b0:400d:c09::232 is neither permitted nor denied by best guess record for domain of jakub.kicinski@netronome.com) smtp.mailfrom=jakub.kicinski@netronome.com
Date: Sun, 4 Mar 2018 17:57:13 -0800
From: Jakub Kicinski <jakub.kicinski@netronome.com>
To: Arushi Singhal <arushisinghal19971997@gmail.com>
Cc: jdmason@kudzu.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 oss-drivers@netronome.com, outreachy-kernel@googlegroups.com
Subject: [Outreachy kernel] Re: [PATCH v2] net: ethernet: Drop unnecessary continue
Message-ID: <20180304175713.25a44ac6@cakuba.netronome.com>
In-Reply-To: <20180303161456.GA20194@seema-Inspiron-15-3567>
References: <20180303161456.GA20194@seema-Inspiron-15-3567>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Original-Sender: jakub.kicinski@netronome.com
X-Original-Authentication-Results: gmr-mx.google.com;       dkim=pass
 header.i=@netronome-com.20150623.gappssmtp.com header.s=20150623
 header.b=18TOPH3+;       spf=neutral (google.com: 2607:f8b0:400d:c09::232 is
 neither permitted nor denied by best guess record for domain of
 jakub.kicinski@netronome.com) smtp.mailfrom=jakub.kicinski@netronome.com
Mailing-list: list outreachy-kernel@googlegroups.com; contact outreachy-kernel+owners@googlegroups.com
X-Google-Group-Id: 672804067692
List-Post: <https://groups.google.com/group/outreachy-kernel/post>, <mailto:outreachy-kernel@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:outreachy-kernel+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/outreachy-kernel
List-Unsubscribe: <mailto:googlegroups-manage+672804067692+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/outreachy-kernel/subscribe>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593933797410411478?=
X-GMAIL-MSGID: =?utf-8?q?1594078497618752325?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 3 Mar 2018 21:44:56 +0530, Arushi Singhal wrote:
> diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
> index 15fa47f..5cd4f3f 100644
> --- a/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
> +++ b/drivers/net/ethernet/netronome/nfp/nfp_net_main.c
> @@ -258,10 +258,8 @@ nfp_net_pf_alloc_vnics(struct nfp_pf *pf, void __iomem *ctrl_bar,
>  		ctrl_bar += NFP_PF_CSR_SLICE_SIZE;
>  
>  		/* Kill the vNIC if app init marked it as invalid */
> -		if (nn->port && nn->port->type == NFP_PORT_INVALID) {
> +		if (nn->port && nn->port->type == NFP_PORT_INVALID)
>  			nfp_net_pf_free_vnic(pf, nn);
> -			continue;
> -		}

This is an error handling path so the continue makes sense here to
indicate the processing can't ever fall through if more statements are
ever added to the loop.  But OK.

>  	}
>  
>  	if (list_empty(&pf->vnics))

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180304175713.25a44ac6%40cakuba.netronome.com.
For more options, visit https://groups.google.com/d/optout.
