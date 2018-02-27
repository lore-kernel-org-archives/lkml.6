Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519745552; cv=none;
        d=google.com; s=arc-20160816;
        b=M0RlPvk2DZ8uIE/GLm+QrJbDT/FGCqtoDNI+FCBk8OPlJUzbhxDegPIOE39j4tD7Rh
         f/Q3+vImO9OmPk6lWfj4RFf5Hw/EGfidCkmohoKcDfQWkYPhJ63wMW0P1sxdBNMH/vB7
         YZj0QRUCt7B0RDDusZYca8oEOXY51hpoXM9clB2hTaNy6SJA+b2ocxzhwKvWyNrZVIyw
         /HVTtQVMuS9L+w0GpSt5ch2inM77vahtGSpu7cVlTSFFo6ubyN9X8EMGtTKRqMLVlDnv
         gG/N/mi3lVlqkoxlp7IxR/KYLtUMUQoD42lEfP/Ta2puzkvkQvJTu1B9Q33Dmvo4pVss
         a0Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=rX6YZnbI8SLlVPsthqY98TdXwR4gzr6iNNnN7YKo43Q=;
        b=fS6WAer5vUbGR1Sp0rTiDnrvW/L1g/6Y5Jiv4u4pXhuV/An9sqPnXkm4R/ij+vBqG6
         QMPkDg8gujD3lhG4qh8jNUAU1azi88QwV2csHcvCjHPr4rBaNLYMz0+eyMNzQy+PNGM2
         4jzyB7Fax2alY8kRFlwQFSIHgTTGNC5IASzp5JpLBSU9iFA5Lq19NNID6CAFv6hpbGuz
         q0oANlPL+7xcOBcKYNue+hi3TMOA1lTqYvr1LVaGqkXTSoYMw5hm5oRaIDKigvLr6r9K
         L55S9ljN4VZVxqHz7ll9BlSIqeKb3ApSvWkSSmPvEmGDzStYSM5RUBcA3/C7s5no6kME
         PgQw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=C9G3PXNO;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=C9G3PXNO;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtH216zXlgpMgNyn7h5Awl5lSyi4wGvpf+Ifxj/kDfMa4KIksgVam10cSJkJsXeyDyo226YAEmE3EOdciLFfsk=
MIME-Version: 1.0
In-Reply-To: <20180227133018.7732-2-jthumshirn@suse.de>
References: <20180227133018.7732-1-jthumshirn@suse.de> <20180227133018.7732-2-jthumshirn@suse.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 Feb 2018 17:32:30 +0200
Message-ID: <CAHp75VdwHZxCzppayKaLdGJ++QKTKnZWwfHXOJ_bhMVHOJCu1A@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: add vendor id for Altera
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, Michael Moese <mmoese@suse.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Eli Billauer <eli.billauer@gmail.com>,
	Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593561031161649636?=
X-GMAIL-MSGID: =?utf-8?q?1593568712221926028?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 3:30 PM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> Add the Altera PCI Vendor id to pci_ids.h and remove the private
> definitions from xillybus_pcie.c and altera-cvp.c.

>  #include <linux/pci.h>
> +#include <linux/pci_ids.h>

>  #include <linux/pci.h>
> +#include <linux/pci_ids.h>

Isn't pci.h includes pci_ids.h ?

-- 
With Best Regards,
Andy Shevchenko
