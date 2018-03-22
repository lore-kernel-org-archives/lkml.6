Return-Path: <dvhart@infradead.org>
X-Google-Smtp-Source: AG47ELtX9gUSmh8DIcKT2jImjklKJ516ygaWdui9pim4LIlpbzjCap37UErkAz3xPvpr35vpjKLi
ARC-Seal: i=1; a=rsa-sha256; t=1521762945; cv=none;
        d=google.com; s=arc-20160816;
        b=wAVIyL8RLJFB4vCawBH8/nAaP3dEIEVt9gdgRk9edDMftv11pioZr83Id860Bd6dZZ
         PTef3zc658Ztax4HlU1FarlSXW+VBpKPUBejIk0XlrQP4AO+D7UGVysfBOnsMmVAWAXQ
         eUkPeY1lIwKzNBGpJRjjP7GFL7AMhOBmsn7m5m+7K/e+ihCCkYdSAFXWgveVCNkVt4zz
         VAJGOaEFX3dDe2uUKSPTYWLzZgm1aHDJKiA6/RkpzPCk3iLqg/MFTt63X3eirMFCrATO
         jrjWK/z/vVu1vB6abPgloUlIvMJXthu2iU01XlcckkjbxDvwK093FTFQ8Chw+p55dfod
         zBRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=IO/H7QZpxolpuJo37N7p8vsFQuQJ2pKy8uW8ytfcpc0=;
        b=u+UL7PH4tBMKrbGlp9WDzGfrV9tkyiQmb5Xe9NUZreuOyHsoAD2znnyYSEtrIQtT+a
         y1YO93ZnHZbDgZp+XRp+jTJfoH9n7L7XtSWP0CDaF8EICFSnjt9ahoOFS4RnUqbEl/Do
         ZpJOqtXOxDMZmhT66qgs7xrDluKLvoCj3iZLaCxMgRjsBQ9qUh51lpuleM2ZijwixZLM
         qVE4SEIVk4kD7A0VMaQWszvM0hT/6+juovDrsRObsPJvqnmwo2tEmPAvot48KwoLHYdX
         8sQ/Vc20Zc/9ACdZZQtDWIgvf8nv8zL4f7h2PLOnA4bczQlJ17VsPM9RpRxwTKKyl7Du
         okhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Aq1V8ZPT;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=bombadil.20170209 header.b=Aq1V8ZPT;
       spf=pass (google.com: best guess record for domain of dvhart@infradead.org designates 2607:7c80:54:e::133 as permitted sender) smtp.mailfrom=dvhart@infradead.org
Date: Thu, 22 Mar 2018 16:55:41 -0700
From: Darren Hart <dvhart@infradead.org>
To: Vadim Pasternak <vadimp@mellanox.com>
Cc: andy.shevchenko@gmail.com, gregkh@linuxfoundation.org,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
	jiri@resnulli.us, michaelsh@mellanox.com
Subject: Re: [PATCH v1 0/4] platform/x86: mlx-platform: Add bus differed and
 auto detection functionalities
Message-ID: <20180322235541.GD24138@fury>
References: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518559776-188942-1-git-send-email-vadimp@mellanox.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592318011865134700?=
X-GMAIL-MSGID: =?utf-8?q?1595684101856529186?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 10:09:32PM +0000, Vadim Pasternak wrote:
> This patchset:
> - Adds define for the channels number for mux device.
> - Adds differed bus functionality.
> - Changes input for device create routine in mlxreg-hotplug driver.
> - Adds physical bus number auto detection.
> 
> Vadim Pasternak (4):
>   platform/x86: mlx-platform: Use define for the channel numbers
>   platform/x86: mlx-platform: Add differed bus functionality
>   platform/mellanox: mlxreg-hotplug: Change input for device create
>     routine
>   platform/x86: mlx-platform: Add physical bus number auto detection

Vadim,

I have rewritten most of the commit messages after parsing through them
and reviewing the code. I believe they are much more concise now, and
make the intent of the patches much clearer. I have not changed the
patch content (code).

Please review the commit messages for the top 4 commits:
http://git.infradead.org/linux-platform-drivers-x86.git/shortlog/refs/heads/review-dvhart-mellanox

Does this still match your intent?

-- 
Darren Hart
VMware Open Source Technology Center
