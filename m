Return-Path: <logang@deltatee.com>
X-Google-Smtp-Source: AIpwx4/YlldZht351fSyl2vAxJ0po8B6dvE3WSBwDsu6l0qEOOFSNP1J6kU21IE53bEn/6Gb6bU5
ARC-Seal: i=1; a=rsa-sha256; t=1521661653; cv=none;
        d=google.com; s=arc-20160816;
        b=LIt0VhsLNl9Ru4sHXnyhurTlLOhYidSez1g8jXjrAlR4CcHVaJvjwLJeMDxpF5uoxI
         dwf/R3rqp/V8q4SDTFSTu/6SrmA4ZJM2PLImPzDHgVoXeXp0Bgrs8veVmPgDIa185cnT
         vEF8Z5xNXcbJqQn08FFsGztaOXffnB/d0Qpc9APFLWTUn4K24nu1TiHoXaQhgsjdJfVx
         Dk3ZsJLmH6ayqzu3jRxL2tREntXMtCt3yQLQRgo3XGUS9/a75nS/3nzBfQdBu9S29EUh
         2hpC5un5tDTucXj7gA5ccN4QYLH3IY4Dr67SJGtzMNvMMHzUO60OaHkT0LgbSJeZJPQ+
         0mDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:content-transfer-encoding:content-language:in-reply-to
         :mime-version:user-agent:date:message-id:from:references:cc:to
         :arc-authentication-results;
        bh=wWXm25/iNtLV5njasEbiLQkHwZUOH1Uuyi7r5e/ingw=;
        b=lpn/ATSzL1AvvdnpzdZ9Vm15Qa0BcxZeZvwxKg/o42HzHkCa35kulUw5MlopHQNiLA
         RDQM0j+5f/hpN+225cwCn2bq5Tm9WObvD2e8NIcR1OCjwk11+7iJFyh/F19drAVsjJhH
         QTD2CC9y14SY1NcF3VxHiU2+dt/umAVxxDmMaxT929Gh3w970BxPCp7JnT9ZQ/rTdpNv
         f1TILfP1ZqQiONe7+5RGXVfYDOVJiqq8rwm78mHzyOxJ72MeIjrrhRii7F4u9RHaTSql
         Xcu7Nbt/HqlTxex07rosGnpb645ymntHs0cbF6qFXkrSxvr+QRMK0R9igK3PWH1C0Aur
         YfKQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of logang@deltatee.com designates 207.54.116.67 as permitted sender) smtp.mailfrom=logang@deltatee.com
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux-Arch <linux-arch@vger.kernel.org>, linux-ntb@googlegroups.com,
 linux-crypto <linux-crypto@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, =?UTF-8?Q?Horia_Geant=c4=83?=
 <horia.geanta@nxp.com>
References: <20180321163745.12286-1-logang@deltatee.com>
 <CAHp75VdjiBvAROe_rkqqWVZUPSnXQgrURZ0CUq1gxss+vJge3Q@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <731d2948-cf05-7595-9cb0-ced681ac6c40@deltatee.com>
Date: Wed, 21 Mar 2018 13:47:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VdjiBvAROe_rkqqWVZUPSnXQgrURZ0CUq1gxss+vJge3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: horia.geanta@nxp.com, arnd@arndb.de, gregkh@linuxfoundation.org, linux-crypto@vger.kernel.org, linux-ntb@googlegroups.com, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, andy.shevchenko@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH v13 00/10] Add io{read|write}64 to io-64-atomic headers
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595565960791638927?=
X-GMAIL-MSGID: =?utf-8?q?1595577889811794063?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 21/03/18 11:40 AM, Andy Shevchenko wrote:
> The first patches that I didn't reviewed before makes sense to me, the
> rest (at the end) FWIW,
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Great, thanks!

Logan
