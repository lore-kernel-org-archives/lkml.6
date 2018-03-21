Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AG47ELvfq5anaiA4MCSvoiTQvHqSGdCtcLBP08oszLSPc+6u/uGMia6cbGfXZ24FHwrgUt52XTRg
ARC-Seal: i=1; a=rsa-sha256; t=1521645665; cv=none;
        d=google.com; s=arc-20160816;
        b=yxnVL51eFQpktbujnMiSOa5A7FSYXRIV7xuwZivEsjC4bhEjww6mzC8+odveaW1ATJ
         zSv/PO+Dfn8If9oA6BMTGOfaV2R1cOBKAVqr3p1ttT6+7Tf00YNBo7FlCDGuP18fYdsD
         7Jh+XNzub5+RNp2OYHVaOrQmK/MT3/wD4mEQ4ZPhpG3TfYmOOE5JNaqWdcQWXTJggYTG
         NemaqxcG6zDzAo6EenROGNy8lpJ6pIIPHO9mFWbJj08yRWeRTLap2M7uK2khMnG7XvSU
         NFbVqeR0MxooBAi2w5WvrILw780JLunuhGwQcitR+7IuNZubUeTuVTjx/QE13T/9gD+T
         qEbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=qJ67ToT5dcXsvPnr9cW7DeP4PlfkTDrbQrTYEjNP39c=;
        b=xvML5q7LPEPhjsMpvlRnsZRNErrQvKKdR/cs022L4jFoOnfb4z2GbYa2IYhipcozQQ
         wNnowqBDbiBNx7/OCdfq3yd22UQ1C5AoZRJtNVy2YpGdUCs1eZaayy2NTsdxjaEDl8FD
         607hJf+/dLPn+iH/kpXk2zhK29YYZRrbWrK371I7tSKbdlaBtytVLNopEg5Zkjo/qdLQ
         O9HKRPepHi0/kyvcQx1gvKPPTGiaTUalQHO5NkHmHOQb5kDy5xhCupDdCI+zg/06dRHj
         arduhqX1Uwqv+hjVWrtkfgvDftbJY6/AzghQ9iFLe6yEP2ouftD+xLZssF2uY4+RXvKJ
         2Jjg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Wed, 21 Mar 2018 09:21:03 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, Alex
 Elder <elder@kernel.org>, ceph-devel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, Julia
 Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v2] block: rbd: update sysfs interface
Message-ID: <20180321092103.786a4db8@lwn.net>
In-Reply-To: <20180223101959.GA4441@mordor.localdomain>
References: <20180223101959.GA4441@mordor.localdomain>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593186668051125162?=
X-GMAIL-MSGID: =?utf-8?q?1595561124681457584?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 23 Feb 2018 15:49:59 +0530
Aishwarya Pant <aishpant@gmail.com> wrote:

> The existing sysfs interface has been updated to be in the same format
> as described in Documentation/ABI/README. This will be useful for
> scripting and tracking changes in the ABI. Attributes have been grouped
> by functionality and/or the date on which they were added.
> 
> There are a couple of more changes:
> - The attributes have been annotated with file permissions RO/RW/WO.
> - Added description of the bus attribute supported_features

I've applied this one to the docs tree, thanks.

jon
