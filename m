Return-Path: <hal@dev.mellanox.co.il>
ARC-Seal: i=1; a=rsa-sha256; t=1518004148; cv=none;
        d=google.com; s=arc-20160816;
        b=NG/PRdp5Rsu2+CPtEMGxnn4yWxHYNd1LW10STxhnmXo6B8eZft7hIX+Z5dyh/ubwMe
         oThABX+wcSL6QRo4Oc7yJ/y/ZdngjeCFQA6xVvn9KXAwjWgbZQmCVVBva0kdMOn5EaBK
         F8dwMlchwytK1eDxKiaZm5iehdWNSp2J5hiTtGuzGIqtapLzQAevaE+n9dNj4/TcYyw3
         Pnozi4iIkYWbvVZKlnlJIFMTQdTGaCGF/L6Fp5vQaU/0mXPT9hHBCLy3E/nnbhUewoDm
         KwSubiboC3mEpwqK8pi3WT+M5StUiReQHcD4GizqXqWFBcysP495Nu74M9yZDSNMsnz5
         T/kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=58ktikldWtak09R9slCfknMcWh/HB7Glc7WxZ3uJEfI=;
        b=x3qX5Pz0Fk7niqOB+4IP7TCl9f+RovOyNDTjuAzVOg253VtVycp3KDSKqNBNXwZMiY
         OCGVjomehdEQbmeScCAY3Pbfdclcv6pvkurWEefEN6AlmmDUJYFodzD+2SE9WgvmHI62
         Y+rf/yC/8ro38DXTg0xU7bO8zbV3EKkpTOnOjBhZl4+t9wDMW3ldfAwP1pasmyvlo+DG
         DlhYSy0PkmQP3jpbVy9kQ9YHXAoJGJJ7pXPfXz4Uib/G0pKkNWdqKkgOHQ5Q1DtJGKll
         3toqe3tZLpnETqsIMPQzOym3Vn1KsP47iIDf/kEBEXUPKRsj6TiuQ3/OMR0B+eryFrld
         6OnQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.s=20150623 header.b=I/GRzDlx;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of hal@dev.mellanox.co.il) smtp.mailfrom=hal@dev.mellanox.co.il;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=mellanox.co.il
Authentication-Results: mx.google.com;
       dkim=pass header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.s=20150623 header.b=I/GRzDlx;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of hal@dev.mellanox.co.il) smtp.mailfrom=hal@dev.mellanox.co.il;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=mellanox.co.il
X-Google-Smtp-Source: AH8x225QXls/8rWLt+5dvuS62r/cSp4Z0a21fDo9H2ElBVh4/VLj/y6TxYQNR30snTJbgqcxLl5qKw==
Subject: Re: [PATCH v3] Documentation/ABI: update infiniband sysfs interfaces
To: Aishwarya Pant <aishpant@gmail.com>, Doug Ledford <dledford@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>
References: <20180207045955.GA31749@mordor.localdomain>
From: Hal Rosenstock <hal@dev.mellanox.co.il>
Message-ID: <22426e9d-2ffb-b155-beca-2fbf2b300f3e@dev.mellanox.co.il>
Date: Wed, 7 Feb 2018 06:49:04 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207045955.GA31749@mordor.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591716983229332974?=
X-GMAIL-MSGID: =?utf-8?q?1591742717307425698?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/6/2018 11:59 PM, Aishwarya Pant wrote:
> Add documentation for core and hardware specific infiniband interfaces.
> The descriptions have been collected from git commit logs, reading
> through code and data sheets. Some drivers have incomplete doc and are
> annotated with the comment '[to be documented]'.
> 
> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>

Thanks. Looks good to me (the device neutral parts of this which I
reviewed).

Nice work!

Reviewed-by: Hal Rosenstock <hal@mellanox.com>
