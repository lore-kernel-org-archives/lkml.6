Return-Path: <damian.tometzki@icloud.com>
X-Google-Smtp-Source: AB8JxZr2SvszazNqYAHiVKFekHa0Gfg4krvGLdJ44vlJMSaARZEthNEMMQfihzFn25i+1bo36E9i
ARC-Seal: i=1; a=rsa-sha256; t=1525291403; cv=none;
        d=google.com; s=arc-20160816;
        b=xf4eHmcPWsFwVMw6zHBx2FJ8rn5nDKBV/idhzjleITeJuAvtdI9pZJQPnvaU8Px4ij
         oGa3Hm4liGnPr+/lReuaOatEsxVWHXnpt1LrJ03ChAe2XYG6tD5gPXtXEBC3a0ycy1Ko
         A0KA5kJdhFYOwdy5rcTMWoxaPZK88EfcLvNIwEYpf7kmxWgHMG2PGvcvRjNiB7nKZp7S
         R449yjPvvGPnx3lJJuCudejbFEWvnhS4kiN1NRYnW9anEBs1il1M2IieRF+s9Gaf0QSG
         rSz1r8f5kWde4YkxvoQnRMioZZQmVunU6JTHQWSipg4ZBi7JIREd1Wj2/v9XXSsiTnfZ
         yqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:dkim-signature
         :arc-authentication-results;
        bh=Rlz6qHSXaRwoUzmAaB6tUQRXsfRs9vgAUet6d71J5Y0=;
        b=m+JfVtXtYSMDyHw9I0xnSGs97apLJUilP/7dWIxhrd75tYuqcUyn0QfdeBFoWFRjVH
         nPkkAnew3gRRmVGXgVb0lK38chb+xJtyN64eJ7rPiG5A5xD/KD4OMFQT2b5YiOV1ANlj
         5RCW4g2xFySzYty3mEL0nwpwc8VXMT0yT7u20CHjeh9TtnYMHbOyOOdelg9hihEFwxqU
         oZKIgdCEK4Po3KWUiUxqSVBJ2DlqwOoW+AyubLD1XEk6Q6ntyWxSJD2mKivDCbdC6Z5A
         hKcOFhjw93sDsroEPOwgBOdy9VkEXCO5sSk9o4sHB+MYlxBfdlz4+xzVzRXIhhHnFURI
         OZng==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@icloud.com header.s=04042017 header.b=jvd5XuSf;
       spf=pass (google.com: domain of damian.tometzki@icloud.com designates 17.139.149.167 as permitted sender) smtp.mailfrom=damian.tometzki@icloud.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=icloud.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@icloud.com header.s=04042017 header.b=jvd5XuSf;
       spf=pass (google.com: domain of damian.tometzki@icloud.com designates 17.139.149.167 as permitted sender) smtp.mailfrom=damian.tometzki@icloud.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=icloud.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-05-02_07:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1805020169
Content-type: text/plain; charset=us-ascii
MIME-version: 1.0 (1.0)
Subject: Re: Bug in vboxguest: After commit Merge tag 'char-misc-4.17-rc3'
From: Damian Tometzki <damian.tometzki@icloud.com>
X-Mailer: iPhone Mail (15E302)
In-reply-to: <20180502193735.GA2444@zrhn9910b>
Date: Wed, 02 May 2018 22:03:17 +0200
Cc: linux-kernel@vger.kernel.org
Content-transfer-encoding: quoted-printable
Message-id: <AD91D21C-CB83-403D-A521-EC5949E76B20@icloud.com>
References: <20180502193735.GA2444@zrhn9910b>
To: hdegoede@redhat.com, arnd@arndb.de, gregkh@linuxfoundation.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599382342256929089?=
X-GMAIL-MSGID: =?utf-8?q?1599383958424885704?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello together,

after commit "Merge tag 'char-misc-4.17-rc3' d8a332730e757129e70675679f2b2a0=
3f1ecf65e my virtualbox with Ubuntu 16.04 no longer works correctly.
The focus on a window for example "terminal window" only works very delayed.=
 Or a move of the window with the mouse isnt possible.=20
I reverted the commit 'd8a332730e757129e70675679f2b2a03f1ecf65e' and now wor=
ks all normal.=20

Best regards=20
Damian
