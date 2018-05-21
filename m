Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1526941201; cv=none;
        d=google.com; s=arc-20160816;
        b=Xc7rq2xZTOQ5SdMU+vpkY97NcuYm2jP61+DXjOpvm83MIuqaaNegVMwolto7lTzbiF
         fXGIKoPh68mPw4N4c8srMCaxN7CfStqNRdS9Kiu+vkbQ8Oj5NGuJQGp8mm63Tr0gCF21
         p8jc9h8omev4xIDWqiRttkQDsjh8tAoTiCCOO424CgC0YKizeay5ZuXbJXKg+D+NVQG5
         rwGzkjixesUkg8+ZkX7cECH647nG0jNcCqV2ua0RkjhRw1JDTh8LUFhSA2qrPiFmXAwz
         paaYQa8UxFG4D9TvaclttJkVpgFrY3SFhg/3X5fP9mc/bNzPk8eAhAPgbARVidjA6La7
         w+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=hfyvVuF/SWyWdh6ql7xXwGLeojP0+D8PeVAPgXxWbBw=;
        b=rIMTM4HAqkX2RDuVTbL079pJPLQ+uEI5Doe4I4PEwN+NyG2FboT6tA7zYCTe/uAjfV
         xgsD26ahgZ6N0iIF4mzJi8rUUL844ibJevqBFX3WHUWVyq7BuqjXrzyMYp5OpkfPxrAP
         PDOGveiZBx0TE1qZB91N4rGnSezhDVxx08ofkGwzzBj4pHCmn4AL2Ermb0tfAem5icc2
         ErAZhoRHeywquTBp7oZ3enr7Out23TDEH3eigO/XG968zTx8QW7ShmLqpEGfqH8symtu
         k2iYOrVRy8piI8otUAbqCsUmD1Nozf5bmrILc4ilyU/VdJUURbVWQspM8fP8KWwIyiYU
         LtkA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=K1fNLf7Q;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=K1fNLf7Q;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpj837S+vn9GlnGeBRNwi0ieGMXbrgwV78+Hxv3x1upSbvh/BwPM8wA75Gvy7gVBiqU8xcDAPqAtZmgcN79wWI=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-2-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-2-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 01:20:01 +0300
Message-ID: <CAHp75Ven5JXiaPA50K_fq33L2W+atHT81Txp3D=6j4Op1BHPGA@mail.gmail.com>
Subject: Re: [PATCH 01/33] usb: phy: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, USB <linux-usb@vger.kernel.org>,
	Felipe Balbi <balbi@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601075771849447048?=
X-GMAIL-MSGID: =?utf-8?q?1601113897555573328?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.

> -       int err, i;
> +       int ret;

int err;

would still work.

-- 
With Best Regards,
Andy Shevchenko
