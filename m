Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AG47ELsYjoSmLY/IpjjKTwgXUsG30HCbfOGJi7Em9VA/qe6GK/mgAL3YY1pjuuV4wgShpXlq7c/1
ARC-Seal: i=1; a=rsa-sha256; t=1521646087; cv=none;
        d=google.com; s=arc-20160816;
        b=xfmS42sWrU0RxKHUAAncduIRMpFn4O8Z7ExuJ+N1TFgV68gX6NDn1Wt2YjCSJFn4a7
         nbrtztKrGdRDsHeM2OxbdrQ+kyPUU5UlFo7ULoO4mQqpS1za8b+3XwLOnh6QNHGUNHA0
         Z5N9BouwjtHfxp4or3RG61VylTjW2Z/Ozmv/cvc8oAf/MdmdEWe9kL4QF4Ct5Do9dqcB
         SHGfvsw15SM/KZDENaMDU8BaQ/x5PKBC8BxPCRkS6zd7SRzKGl9CQ4Qg6caHuGrpOZN6
         lrjRbjTB4iTdMAklmotKm17AmYvdrlnE3IOlk7llZytUEf+itEblWn2SyiKcy1+kzyQm
         dRjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=71Pt4j34gCoA9DW2YOdVfcm2N4VEHkeUhP0NwCC60mg=;
        b=Bw5PhiO/0o6rDd8uuJY7C+TO/q+2Zw0hGzv1go7ZK6XAtUHtcu+PwJx3G4ONAEqzsX
         6cHtDQ9uF0DidJ2j4MTQ9OR1s3Cjtw41T3bjH5T4/g23nf8xseHpRA1eyFSvbFmG7jlr
         u8KsOvGbZtmPJNj8Wwwi+vyO3E2F9mpn6iBjSXd55FkCkeDkphMLstRnNqb1Rco5q+qm
         +EnLZuDpMmiy++CihUvLSOx/PMZ0bJ2TUtEHenz4byeYuep8qVXjOB3iNkYiSYTGV1Ec
         sLaSoL23CneN/4x/bPdcogG6fcNhSraeqaFT0k/QD3/8BI9uymiIBEY+vLylQkI7KMa/
         wVsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Wed, 21 Mar 2018 09:28:05 -0600
From: Jonathan Corbet <corbet@lwn.net>
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires
 <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>, Julia
 Lawall <julia.lawall@lip6.fr>, linux-doc@vger.kernel.org
Subject: Re: [PATCH] HID: ntrig: document sysfs interface
Message-ID: <20180321092805.279a8dde@lwn.net>
In-Reply-To: <20180302053017.GA23123@mordor.localdomain>
References: <20180302053017.GA23123@mordor.localdomain>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593802620168296630?=
X-GMAIL-MSGID: =?utf-8?q?1595561567617527087?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, 2 Mar 2018 11:00:17 +0530
Aishwarya Pant <aishpant@gmail.com> wrote:

> Add sysfs documentation for N-Trig touchscreens under Documentation/ABI.
> Descriptions have been collected from code comments.

Applied to the docs tree, thanks.

jon
