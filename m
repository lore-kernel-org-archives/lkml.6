Return-Path: <outreachy-kernel+bncBDZJXP7F6YLRBE6Y5LKAKGQEJWPBQ5Q@googlegroups.com>
ARC-Seal: i=3; a=rsa-sha256; t=1520086036; cv=pass;
        d=google.com; s=arc-20160816;
        b=QASa3LaxVrWJBcNoqktJ3wLq1rW/mJ20KixJfBCBEoL4gcbeySB/5XJ1knAJ7sOsYU
         ojwhDILi07/HvzZ8ogvgYNCxq7O7zPrjeHgl67MLqfHPCJsKq51xhZrkZKM2U79UulGc
         PilTIQVI6p/2LLrrB+zMJ+bjt1vj6pIYbqKC+7OthF5dyooC8lht7VKBYjtBiRIBscZy
         mAI5rl63xX2j8EUuuT1kAMFtwWYQ0UjNwCRUHvPQRCUip7yQM001fGuGp/HvM0ErK64a
         4LiThNNXpIzoFZIFzuwxvuGzQIrZsjm3Jy5VfMAfC0Ew+iDLfg8vEtRArLsK5nU+rTxD
         8kZg==
ARC-Message-Signature: i=3; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results:arc-message-signature
         :arc-authentication-results;
        bh=JqvcDgVLwbP53gUHgNhd5cR5rcKYJy5U/2/Z4aCaKCc=;
        b=MMTdCMcKWkSjE0zWrcXEO+JXcVWzkEpNXyAymrsuZWYHmM6ZmLteO7n86NeSELVY7u
         5gmlokmBRcgCejmYC8D1x6VB5/OkBvHGdSqSuB6ByVKUOX6Fr4twaa35iCEitwjNnrfN
         RnKuBf/cws3swyjpuQXS7gw1LD8pzYpbWJr/OEjayaJX1rrQ74yVTJM0wlz95GzOBavE
         XqZTI8Z9RMmOTlk0UtAoKKFYH/ICAmDjd4oAdr5KGD72NIj8mu88+EtTUHaXk9CFMzEg
         Tapx7zC3RiL5VeWYts3X000eWuTuLv7cgLr0CymnnVdkSd7UPa3koLSFnSHKWB2oFug1
         9Hsg==
ARC-Authentication-Results: i=3; mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=CMhpK30P;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbdzjxp7f6ylrbe6y5lkakgqejwpbq5q@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDZJXP7F6YLRBE6Y5LKAKGQEJWPBQ5Q@googlegroups.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@googlegroups.com header.s=20161025 header.b=CMhpK30P;
       arc=pass (i=2);
       spf=pass (google.com: domain of outreachy-kernel+bncbdzjxp7f6ylrbe6y5lkakgqejwpbq5q@googlegroups.com designates 209.85.220.55 as permitted sender) smtp.mailfrom=outreachy-kernel+bncBDZJXP7F6YLRBE6Y5LKAKGQEJWPBQ5Q@googlegroups.com
ARC-Seal: i=2; a=rsa-sha256; t=1520086036; cv=pass;
        d=google.com; s=arc-20160816;
        b=fsKsWyBaOyw8Lsw05JIsRe8sx3GrXfIMkGyrKobQ9+RM1eijMblADgz9d2bGN2UvOC
         wIAy77MzwX51ioD/j8NnAiWQuPRRavffSF1VJFcldWtAE2prFZuOJDYPWHNEV2fHD8G3
         Oo8ak3gjU235p/JvQaLTVK4JnBhMzCKEWCn742gTC0rRYFgWAFYzc13G3SvCAQfRPovc
         N5no4ye/1EfTU5x+OyaRXgurm8gecoxDu7WLIPj5G+V9VrVY9Gw9Gb2M6iSNYlM/iiDW
         vcUdb4kn0NwDSH8WBhStAhLpqsg4hmngAiI2YwMKIIe13+8+XT6PTWHKgdIBAwU6sY4f
         L3+A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-unsubscribe:list-archive:list-help:list-post:list-id
         :mailing-list:precedence:mime-version:user-agent:references
         :message-id:in-reply-to:subject:cc:to:from:date
         :arc-authentication-results:arc-message-signature:sender
         :dkim-signature:arc-authentication-results;
        bh=JqvcDgVLwbP53gUHgNhd5cR5rcKYJy5U/2/Z4aCaKCc=;
        b=fC3RVVHiAeD+bsziz+3FovyLjm62UW9aYHtmgwxR5MD9bEYThPdPYizERx4UvAKcxv
         HypSr/x1bN3j0+F5LRAX/4KdxAelKpL2UAnmDTIxrV5cFba6LHTwuaDTC0of6LfhYP/d
         2Bur3oTvn6f5dF7kL1+dSUOKOsz0CJJF2//bnVEWC/m0tstZKIGUf2ACRL1QeRdfvQ5h
         bo3istKE0UmJePVPhPVb2plXcNpK7fzx1tBO+hv18kvtxEAS/3/6WNuJkR3u7u3/ShX6
         5NMxInt2rRFskl+/QAyanTgVGETlHA+7XXsTLO0tHOkKMlXiDh0xvC6aQ5ZHy2XgrAUP
         1eTg==
ARC-Authentication-Results: i=2; gmr-mx.google.com;
       spf=neutral (google.com: 192.134.164.104 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Sender: outreachy-kernel@googlegroups.com
X-Google-Smtp-Source: AG47ELuGBGy0KG3NvezHxbM38d9lmbLFqCOeHWe+1nwYHtUZ8bvRxejhyQ58j2kzt7yW5E4s6JxPyA==
X-BeenThere: outreachy-kernel@googlegroups.com
ARC-Seal: i=1; a=rsa-sha256; t=1520086035; cv=none;
        d=google.com; s=arc-20160816;
        b=KNo4+zY1P1OMxLRnTPUVFwBPr9Sj/IoiT03v/j7aoGtBItd5rj6gELsoOOlodmTww+
         ITz/zECL4HtT9mTW3NfZM0Y0KBSKfcivvi+VtBEdK8LJjUq9jZrA4d44uGdIRVNqyL4R
         swUyPFVxzPuDbffboX2IdL9BkPy6EzNWUnoK1oS9KK61s3Dszu1ltUZ375HP5O5CLOny
         w3KAMzlUcnWIH5ZK29Mw5uXePbsZqt75s9Q2cQWvwtjnY8yNlwzOrsPjtmXsubXlj5ua
         IzFF3lVqPsO8pYogIX+cMAPLmLmWz27pj3SCQNbebZtIIDcb4B7H7HCDTDApjfRKbqTe
         eIJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=HUvmxSq8oWiEC1hf0ydF53t08JoQO/PRp/yBiMDTVwc=;
        b=HjHq6jXrWYHzRgVegiBBzKWsJxPEvbzViveLx8pdo07Wo368LJwBm/hqjWtJhUKxnu
         2ELfs3etogb0gemMF7VZ/xwu4ecwkIsBeE8nJ88Og7GNH8kNTJ5pOgi+xSl5nljgoDj7
         UPs2O9LzFBd7zY0M+Z/sihX3Y4ym10m1EQVA2n7b2FiuTLm2KvsHaGqjy9FmdWooEfxJ
         a2l2ym9olAQL12rC2szJ0QeuvqafVn7AHMCD0NwriM+R07Q44LPdQIV4+0CyW3K8oGmC
         TEcj9GE5H9RGzt4+D7Dv6J4Cccj3jHLz7PdL++3pbHGrMWOz4HicHfSkC09Y2e6xGPvy
         bGtg==
ARC-Authentication-Results: i=1; gmr-mx.google.com;
       spf=neutral (google.com: 192.134.164.104 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
X-IronPort-AV: E=Sophos;i="5.47,418,1515452400";
   d="scan'208";a="256828695"
Date: Sat, 3 Mar 2018 15:07:13 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
cc: dennis.dalessandro@intel.com, mike.marciniszyn@intel.com,
    Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
    linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
    outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH] infiniband: hw: Drop unnecessary continue
In-Reply-To: <20180303130336.GA8210@seema-Inspiron-15-3567>
Message-ID: <alpine.DEB.2.20.1803031506550.2302@hadrien>
References: <20180303130336.GA8210@seema-Inspiron-15-3567>
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
X-GMAIL-THRID: =?utf-8?q?1593921759797565624?=
X-GMAIL-MSGID: =?utf-8?q?1593925735881561867?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Sat, 3 Mar 2018, Arushi Singhal wrote:

> Continue at the bottom of a loop are removed.
> Issue found using drop_continue.cocci Coccinelle script.
>
> Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> ---
>  drivers/infiniband/hw/qib/qib_init.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/qib/qib_init.c b/drivers/infiniband/hw/qib/qib_init.c
> index 3990f38..1bd3b32 100644
> --- a/drivers/infiniband/hw/qib/qib_init.c
> +++ b/drivers/infiniband/hw/qib/qib_init.c
> @@ -681,7 +681,6 @@ int qib_init(struct qib_devdata *dd, int reinit)
>  		if (lastfail) {
>  			qib_dev_err(dd,
>  				"failed to allocate kernel ctxt's rcvhdrq and/or egr bufs\n");
> -			continue;
>  		}

Again, the braces should be dropped too.

julia

>  	}
>
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/20180303130336.GA8210%40seema-Inspiron-15-3567.
> For more options, visit https://groups.google.com/d/optout.
>

-- 
You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
To post to this group, send email to outreachy-kernel@googlegroups.com.
To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/alpine.DEB.2.20.1803031506550.2302%40hadrien.
For more options, visit https://groups.google.com/d/optout.
