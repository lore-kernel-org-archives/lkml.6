Return-Path: <davem@davemloft.net>
X-Google-Smtp-Source: AIpwx4/pygdFM/DaIQTqybdTUEKncvz1Gz58efBsjsA3RwKAGlX8Y7a1jqoNIxKVHmCd3zRbgAyy
ARC-Seal: i=1; a=rsa-sha256; t=1524445706; cv=none;
        d=google.com; s=arc-20160816;
        b=IZwvPkd7ZF4obOqvbTW2edzvEJlAp25YEDpyep5CSQ/mm15GKGn3qlViG5Nh/y7wWX
         KZWjNI7731HnkK6r0TCaN4AHCX0F29FJ5reZQ4Rha7jLpqgKqPf8x6zZvRErbBd6TDlP
         WGwa3a0jkvPICHWcqm0BIE7ST2L3MnPihSRBrNk70dq522fW/+1W177FkuAa1H6fl3QV
         I4FkDdfY4jykfOe9jd8wA7/Y/n5J9CUk+c9OI1R6BMakAd1EHqzqJyNwlfUaTs8Vw19V
         UIiF9e6sY0dtDXzTAxBpf8rfHOnImjwCZigs8n4n6aIJOKvQefNKiXuhvNMmC9p2+Tju
         plPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:arc-authentication-results;
        bh=V3nHKzuZfH8jLOHUKd/D5WFMCIJbzZfYUP5iDWxOx64=;
        b=EesjB641aXYkIRcnNk2r74rMJIjNnf9261mQnkArfQIv9Fjcn7yICrcVgvMui+GISs
         xRjnlITK2KtuMtIP/kAF+z+woXTTIEUQnZDgMBFYMU4E37kFmQ/a4+9k98YTqR0zvC7h
         ZnzXL2n0dUdtsLX8G1P4/+/fxsZJ8+ANNs4serekw4/EiCuZvZUV0zoPIQ8Ec13HTVv3
         kQ/cH/lvjmu1cOCquztQ0AjBG9z/4XU+jWvJcxEvfTwUEv1+HgYbqJ4JRlLfd0t1+YgD
         3paSdIn/2N/QgvMLdQStQQgZtgiTfYZmLw6elLM2kyRFJh9ZygN2rKKTYCjc5fyYTNYJ
         FRbA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 184.105.139.130 is neither permitted nor denied by best guess record for domain of davem@davemloft.net) smtp.mailfrom=davem@davemloft.net
Date: Sun, 22 Apr 2018 21:08:23 -0400 (EDT)
Message-Id: <20180422.210823.1454088204642743739.davem@davemloft.net>
To: jgg@mellanox.com
Cc: linux-rdma@vger.kernel.org, kstewart@linuxfoundation.org,
 pombredanne@nexb.com, gregkh@linuxfoundation.org, tglx@linutronix.de,
 swinslow@linuxfoundation.org, santosh.shilimkar@oracle.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davejwatson@fb.com
Subject: Re: [PATCH for-rc] uapi: Fix SPDX tags for files referring to the
 'OpenIB.org' license
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180420154910.GA2519@ziepe.ca>
References: <20180420154910.GA2519@ziepe.ca>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598280819210868767?=
X-GMAIL-MSGID: =?utf-8?q?1598497180740500560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Jason Gunthorpe <jgg@mellanox.com>
Date: Fri, 20 Apr 2018 09:49:10 -0600

> Based on discussion with Kate Stewart this license is not a
> BSD-2-Clause, but is now formally identified as Linux-OpenIB
> by SPDX.
> 
> The key difference between the licenses is in the 'warranty'
> paragraph.
> 
> if_infiniband.h refers to the 'OpenIB.org' license, but
> does not include the text, instead it links to an obsolete
> web site that contains a license that matches the BSD-2-Clause
> SPX. There is no 'three clause' version of the OpenIB.org
> license.
> 
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>

Acked-by: David S. Miller <davem@davemloft.net>
