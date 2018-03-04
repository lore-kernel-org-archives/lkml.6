Return-Path: <julia.lawall@lip6.fr>
X-Google-Smtp-Source: AG47ELurvuEShOqPOKB1FMMFLS3A+jP5gi4KL9oh42hQLxcxHD7MuSa7cIRqJ6s75+L5dNWl468D
ARC-Seal: i=1; a=rsa-sha256; t=1520178948; cv=none;
        d=google.com; s=arc-20160816;
        b=WMHGHz+u22VVwZqDRD8hbEULT+xjw2/tJwAU+ldU5Qo7cBX7pCJYbWJzFl4DOa2k9B
         5ZtFEzoHI3AekZnAiW+m85O+0UX1ObUxUSG23I8tphCOJJ7KpEZC5XaneXV5sMnzLZxE
         nufBa5jGEEs0loBo8jJEt4ECjwowSadGWzlF8bhQZ73h0VdchB2MRBVem5HX4Ydlmc8d
         /kvNSaxEPqA+SCzhfAHulZH+FeSLEj9fVCSvOxO//tgQWIhdpGkyQMBjaKgvX4p2UO04
         AKIEIbLoBdUx++H4BdJ3lMcOYepEUoNMy4tAvqVkSqkM9wOxt3r0gusxy6LAWcHgVO0l
         F3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:from:date:arc-authentication-results;
        bh=z2bChMzWfSawa8c191aw8vrW3DZRUzVqIWsJceXXtaI=;
        b=FS5e6/c3Pza0Y4NPEhyEKna2bwyq7ZiUVLMEvth80IrxOVO9LR2OXVVBgA2ASuXTuA
         EeQqkI9BJoeFAWz5QoMnYI7R7iRmhroI64ATnvXpZEkQ7Dn/Kg64S7JZJoleNbnL6JG/
         8T8dQq9vl578dpBda8wEOuXPlyiBHAvEozRg/kHrtzS3QDQKt7j+BKOVetULcXFoVWCi
         YuMm2v0xekHdwfqNxB6zWcTA6kAaTRoyHz8D7vo3RJypPWdP8TyOxZboyNIwB95afHzO
         GPFiK2eL4mSWdihxMt1QQav/sPZZPTMDZekPHI7iWmmBrw3rB6vqZCQe8TIbx9d8zr8B
         +efA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 192.134.164.83 is neither permitted nor denied by domain of julia.lawall@lip6.fr) smtp.mailfrom=julia.lawall@lip6.fr
X-IronPort-AV: E=Sophos;i="5.47,423,1515452400";
   d="scan'208";a="316312033"
Date: Sun, 4 Mar 2018 16:55:39 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Arushi Singhal <arushisinghal19971997@gmail.com>
cc: oleg.drokin@intel.com, andreas.dilger@intel.com, jsimmons@infradead.org,
    gregkh@linuxfoundation.org, lustre-devel@lists.lustre.org,
    devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
    outreachy-kernel@googlegroups.com
Subject: Re: [Outreachy kernel] [PATCH 0/3] staging: lustre: cleanup
In-Reply-To: <1520172968-17448-1-git-send-email-arushisinghal19971997@gmail.com>
Message-ID: <alpine.DEB.2.20.1803041655150.2182@hadrien>
References: <1520172968-17448-1-git-send-email-arushisinghal19971997@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594016958019795729?=
X-GMAIL-MSGID: =?utf-8?q?1594023161469256953?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Sun, 4 Mar 2018, Arushi Singhal wrote:

> Spellcheck the comments.
> Remove the repeated, consecutive words with single word.
>
> Arushi Singhal (3):
>   staging: lustre: Replace "be be" with "be"
>   staging: lustre: Replace "to to" with "to"
>   staging: lustre: Replace "dont" with "don't"

For the series:
Acked-by: Julia Lawall <julia.lawall@lip6.fr>

>
>  drivers/staging/lustre/lnet/libcfs/debug.c             | 2 +-
>  drivers/staging/lustre/lustre/fld/fld_cache.c          | 2 +-
>  drivers/staging/lustre/lustre/include/cl_object.h      | 2 +-
>  drivers/staging/lustre/lustre/include/lprocfs_status.h | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> --
> 2.7.4
>
> --
> You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> To post to this group, send email to outreachy-kernel@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/1520172968-17448-1-git-send-email-arushisinghal19971997%40gmail.com.
> For more options, visit https://groups.google.com/d/optout.
>
