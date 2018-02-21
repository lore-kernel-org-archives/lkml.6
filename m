Return-Path: <dan.carpenter@oracle.com>
X-Google-Smtp-Source: AH8x2257kvQ/Ae1i6nNXULXZlgZFAt4+ox15tdEQWuNAqSpDbzp4PU1Ew03LYn1VwjuRdLk+UkYL
ARC-Seal: i=1; a=rsa-sha256; t=1519215533; cv=none;
        d=google.com; s=arc-20160816;
        b=Ug4Tk7FWu8sJtpPySU6hmqqD9ql4CGJWBhEovUD/WIpX78jXNyE5K8TA2QUCtbIA9P
         mF4V3eViTapbxnjYE+R3itjFJF9YnjvakijMxPB0lav003ivXDqGPYsJRN23I2J9ohwZ
         //aDp8vT60mnTD84JcXKuakvRVGZnCsnAUx87F9JfjK7IPQuU+4yvo9dzL9BPpIC2F+Y
         VOzy7RNWxpdtA3mgevqZ4KVfxseFM0CZ3tpN5el3C00WHkweDW2HKguhEgTY2fUoUX8l
         ZbXqQEusiSuhEOFc6oIJYQFI7aqTqBD3Hb6v5JWS88vNOrk5M2sL743+LwhtBCFStx2I
         mzkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Eu2wQmYxU/mbASbUn/sFkocTC1QA0MpJdIsuSXsqXWY=;
        b=JMevX8fwMjvDQbaHkQHh0p6UHkkfOKF5czNT6U6olVQTkk7fg846a1eX/mMDKYfgtO
         ZfeChl1yvGYpd1WhcQPRy5NBSQtjyEqoznfQcO+JdWcqCJI2m0RTDkNSoVQZ5rV9k3Ik
         TlC6MqVwy5mxtfkXQeZ+cv8x/GO7O9N1Uy/gD3I7CIg6F6IvFEw08o/KkKmhClV63Zf2
         hWT++FvcSkfy/6K/G9R1Snwhif7hZcaK+5oCpA2qz4Y4z/Zxm/i5y4YRZlpKxB0N5YvS
         I8Q1MHpEmnDa2225YIAVuj9cnMH0bAQw6pXj+X3wZzJ2DRALbMYXmyXkzaLW7mqJuAMr
         pIFw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ckb7QThA;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=ckb7QThA;
       spf=pass (google.com: domain of dan.carpenter@oracle.com designates 141.146.126.78 as permitted sender) smtp.mailfrom=dan.carpenter@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Date: Wed, 21 Feb 2018 15:18:36 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Quytelda Kahja <quytelda@tamalin.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, jonathankim@gctsemi.com,
        deanahn@gctsemi.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: gdm724x: hci: Changed camel-case to snake-case.
Message-ID: <20180221121836.x7hbtzg5bglnmitp@mwanda>
References: <20180221103928.19599-1-quytelda@tamalin.org>
 <20180221104558.r7qgxyqshy37gej6@mwanda>
 <CAFLvi21KhXb0+Z3V6Dfv9QrK3via_r6Ggoku5D3mpG5NEYeQ7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFLvi21KhXb0+Z3V6Dfv9QrK3via_r6Ggoku5D3mpG5NEYeQ7g@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8810 signatures=668675
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=769
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802210151
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593006710117877151?=
X-GMAIL-MSGID: =?utf-8?q?1593012946988539560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 03:15:54AM -0800, Quytelda Kahja wrote:
> That could be the case, though I'm not sure where to find any specs.
> Though looking through the history of this driver, it seems that some
> of the variable names have been slowly changing from camel case to
> snake case.
> 

Actually, that's fair enough.  This either is never tested or it doesn't
affect user space that much...  The change isn't any different from
other changes we've done.

regards,
dan carpenter
