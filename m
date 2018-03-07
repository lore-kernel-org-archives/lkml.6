Return-Path: <kai.heng.feng@canonical.com>
X-Google-Smtp-Source: AG47ELtvTben833TsowRYNdrZ/bxtnH6sOWC5hroZowbfe3ebisfn6e4g29IoQ8YWcuIG7jmc3Yz
ARC-Seal: i=1; a=rsa-sha256; t=1520402996; cv=none;
        d=google.com; s=arc-20160816;
        b=uIdyksKy3Y3nYSA7qwaNqY7FIfXcrD6bm9tBfiDmeClHVzZj2+CuAQN5Z0PTP9RFOV
         /aAYAwBLadujn4xhyVVoXzO7IOOwYO4om5bEv/a+sZrO71jiXeAyID7ptCR9Kfl1cID5
         xmZNw4Dj8q9+kUvxWd8oH1Sar7/Yq8HRyWbFRVsdgYeVbG3v3HYbT3nrNe+LaYRt2djI
         w4Csm5FPmDFOOdPEZYbaEzsmm7UaSlQPQIMuIUgnciNnIxgwQ0BbNfzq1DJFxxNT8QwU
         b1a63SgKqvdGu4DSAYVsdllCHPRIEIfoKZyMIoAe3Tq+InXY9vwBBc4N1v+Ckqs8LQ9a
         wVVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:arc-authentication-results;
        bh=xXQ8DcIC5DFp9fxy9q+TqroZ1NjGhA/v2UNi/SGUguA=;
        b=GSOysbPdxkrCmA8UVkbo2gzzp4Ha5BtMwN5NIMDH1NIyS0RxXCtadHdf1oP/SwKpAU
         cMQKx1N8pHyJVIkxJ62Byg1bBw2hkV0ZvruB1fmc5nJ/QekAu7uLc42w7RG7StE9Ys7r
         8p8Slkz5NoYXCKsORvutvbHDZmtREm+k8O0lHjDw5t4pGfnJuMhZ0FfSe2F8JAVr/jsP
         g04iKnH1lKgxMvLKFrq4ivIjIAqbJFMHc6SR1+USAq1qfX92bXGpbC3tZ9+qmOHIfe6g
         4MmiaiKK4Ed9x0zvR4PPEweTwWwRiUEeNkF4Td48i6+UUxXb5dE2bnVvcm9n7v5Ak8Tr
         zZNw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of kai.heng.feng@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=kai.heng.feng@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of kai.heng.feng@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=kai.heng.feng@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Content-Type: text/plain;
	charset=utf-8;
	delsp=yes;
	format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.11\))
Subject: Re: [PATCH v2] xhci: Fix front USB ports on ASUS PRIME B350M-A
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <8579E16A-AA34-4876-9B62-D023B8FC2212@canonical.com>
Date: Wed, 7 Mar 2018 14:09:48 +0800
Cc: mathias.nyman@intel.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linux USB Mailing List <linux-usb@vger.kernel.org>,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
Message-Id: <108BCB45-433E-46FE-B8C6-53D2838480F8@canonical.com>
References: <20180219190621.6632-1-kai.heng.feng@canonical.com>
 <c32af5ea-c8ca-b68b-790e-102c7a8f89f6@linux.intel.com>
 <8579E16A-AA34-4876-9B62-D023B8FC2212@canonical.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
X-Mailer: Apple Mail (2.3445.6.11)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592857395657156478?=
X-GMAIL-MSGID: =?utf-8?q?1594258092468403257?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Matthias,

Do you have any concern about this patch?

Hopefully this can get merged for v4.16…

Kai-Heng
