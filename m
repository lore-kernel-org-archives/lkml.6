Return-Path: <aishpant@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519390860; cv=none;
        d=google.com; s=arc-20160816;
        b=aMREVJpvlVQoJXMCJb5Dp0q7V8dqC6ZG41lCntxDWloavXIfBM6UDDSSWFs9mWoMsp
         wo8q42Fffw+clOgNKAY83dgnu6nF1nDLn4kL/RZS+p6xzCl7bcf0x98ICEBYluAeV51h
         3HLUmfL06YjJweU8P1FXM4bUMdIwEpRMlXezPfejg1HrQ8vrNof4w5FE0v37fMh+Hiom
         C9sz896qnT9QeMzwQA6ZGy5REhGqmqFZd5sA3S7AQlykdQS1W3mSaCWaqi5wOwWJksgC
         2Q2vZgXb5nkfuGIOJVA5jG/MKnK/YSYHsRQct+SPuV7TQrllw2u65m30/Hr33KHN1kad
         j4DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=jjOx9bm9j8zyw04qQkQ8aJtxPMz4ayTwSRUSDOpBCn4=;
        b=YXxKQJoGVa+yLVsV425m19FdjNNn0D3v0oRGYAqq6rsX6PiRxbT25sGrxSBklA7Yow
         frQ85w+LqgxoxqScgskBV3jhFS7HiDU1/Z+HMgOpDRfBxYn8+15yLKY3xeS6wfP0GHWc
         J0Ffetudqe4LpIygBGQ1ErGosDtuEGLAcIyal4wErzVptZR1gwWGkLUsHRMCzkzSYe+n
         lVjj+dlnuDvzPd4Zk20y/f20pCnzM2mQiu1zsOpDQl+7IQFXhvBoJmrY3dz2z6+DxZ6c
         EJiJz0D+4sfd/rb0d/JgZCOjv8FPRGqTo4bPEpExBnh0NONtv8RxqsjVzYJEcVF0Wjyh
         yTXw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=chZuThwN;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=chZuThwN;
       spf=pass (google.com: domain of aishpant@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=aishpant@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225GbVTKpi+2wxkJuGfwEcsvsuYXEu37QKrcNXhXqTOeqim7qNLQdlirsptDxXh6nFoksFqomQ==
Date: Fri, 23 Feb 2018 18:30:53 +0530
From: Aishwarya Pant <aishpant@gmail.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
	linux-nvdimm@lists.01.org, Linux ACPI <linux-acpi@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg KH <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH] acpi: nfit: document sysfs interface
Message-ID: <20180223130053.GA17196@mordor.localdomain>
References: <20180219180754.GA31007@mordor.localdomain>
 <CAPcyv4iQzEeZO-LYPvKQJHzrb3mrgENWZdnH2LzDV49tyfNM2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4iQzEeZO-LYPvKQJHzrb3mrgENWZdnH2LzDV49tyfNM2Q@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592853719340363229?=
X-GMAIL-MSGID: =?utf-8?q?1593196790949483422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 03:46:06PM -0800, Dan Williams wrote:

<snip>

> 
> So, this looks great and is something I've had on my backlog for a
> while. That said this is a bit incomplete. These attributes are
> relative to the the "nd" bus which is the libnvdimm sub-system sysfs
> interface. This document describes that sysfs layout [3]. Ideally that
> content would be converted into Documentation/ABI format and merged
> with what you have done here into an overall
> Documentation/ABI/testing/sysfs-bus-nvdimm file.
> 
> I realize that's quite a bit more work, so I'm fine if we start with
> the nfit attributes and save that follow on work for a separate patch
> in the future.

Thanks for the review!

I'll keep the libnvdim interface in my backlog for now. I just sent a revision
of the nfit patch with the suggested changes.

Aishwarya

> 
> [3]: https://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm.git/tree/Documentation/nvdimm/nvdimm.txt?h=libnvdimm-for-next
