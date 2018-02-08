Return-Path: <pombredanne@nexb.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518099878; cv=none;
        d=google.com; s=arc-20160816;
        b=Hk7hHDs9foC6J23mXIMUjNj7PibeFZETHe6cjhHfgPOm9Pj2lWvYS7Eg1zrx4/SrkL
         LX038Dnb9WsNOJrTXmrumoia68fAYccu/pV20TAobMXNFKbcPbXHNKX88VIv8maJOsu7
         gO2PV30NCFcpu2wyz7MuO/rIsVKw0EFf1MtxIzRAxcoobjvSgZyFDnFqTqcCwqrd3EWS
         QEuHvl0ZfPPRxjn2Tdv8eTkfmzd7tJZ2LnnN9gdEfMUR8sX+mVsR1Mg0EFQs2TrPzSH4
         Py13GKGBD9xw+2GNIkL4pXvqauuTV2xUEl1ad+0PdChoe4JCf9xpZzPXQfpr56Empn+X
         lLgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=58tqtoKmJuqLcJxuWNt4jKI6qV3t0oqqb5A9zWf9gfk=;
        b=BCaZH6cpzunSblnnIh/zlSqRMFOCAFXvSjT+ZERwOcaw/R50SnW8CITXMdk+Iw87AV
         eLHL5g9lXkTNwF/k8MogtLsQpJ1HuMWYnLBheCEhhshvR8EH/aWrpUqKc7TDZWmJSt0y
         737Qz0d47uHfskt85Mg95Ojv2LMqU2uavoonysERwqiAO0kbdQ4ICzKBylnkFke+t2LO
         PkErjK6yVt2QxQai7j6xQlQ8Viy+thd/ILL1UZft7S7ZOIpwW6Q3k/PvcbKTw8PZve1s
         MynGSmnGzKUoOCZ8PckPXIY2fXCZldD+PTTaKPB3W3adBVo9UpmryuHhEqlM7C7AyAkM
         ZCQQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=labXpcSR;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@nexb-com.20150623.gappssmtp.com header.s=20150623 header.b=labXpcSR;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of pombredanne@nexb.com) smtp.mailfrom=pombredanne@nexb.com
X-Google-Smtp-Source: AH8x227cfUYJVqPfm0H8hmy9AsX1aLTkk+7D010aSc5wKLM+ug45J8Q1hOBuTkYDknvJL+sYrSgL71yLWnwOvk2WFNU=
MIME-Version: 1.0
In-Reply-To: <20180201211429.32696-1-robh@kernel.org>
References: <20180201211429.32696-1-robh@kernel.org>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Thu, 8 Feb 2018 15:23:57 +0100
Message-ID: <CAOFm3uGrjZKrrGmJiCFigPpLDEYTatXOvou0W-1z23HkxgQqew@mail.gmail.com>
Subject: Re: [PATCH] checkpatch.pl: Add SPDX license tag check
To: Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591234706723646014?=
X-GMAIL-MSGID: =?utf-8?q?1591843098376028414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 1, 2018 at 10:14 PM, Rob Herring <robh@kernel.org> wrote:
> Add SPDX license tag check based on the rules defined in
> Documentation/process/license-rules.rst. To summarize, SPDX license tags
> should be on the 1st line (or 2nd line in scripts) using the appropriate
> comment style for the file type.
>
> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Rob Herring <robh@kernel.org>

Acked-by:  Philippe Ombredanne <pombredanne@nexB.com>

(Sorry for the late reply but I was busy with FOSDEM)
