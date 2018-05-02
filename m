Return-Path: <damian.tometzki@icloud.com>
X-Google-Smtp-Source: AB8JxZqlT0MldGeEDZHyCBb+KkNTJv2f/kOus3FKMmEhkVUFM1aVNYQjstYE7jxiaT9IcDFOiwkg
ARC-Seal: i=1; a=rsa-sha256; t=1525289861; cv=none;
        d=google.com; s=arc-20160816;
        b=IPHTNpRolsvp6a2JLHl+2D3as8E3rnEdMtEzx5UsQZlvBYPAP7AfWcUNrvkRniLppz
         v3QhvvLlYSqPDHBzBmTxQpRuPkus8+L52+/1N6sNVxcIobRu0RJf06bFbZEh+6NW9IC6
         KFZUNZv5DklHHwQJw1YWs/8qhD9R/877wcFPzMDATry4Lq6yY1Qo1PVaBkhbb13Ft5Cv
         F4c/LjASth30YQ4f5oOjmceSDgR06Ldqm8jTEYg+XmAVVLurcSqTCuc0MPehsOhYpMsw
         WOtnthe4J+D2TABfUksjOsyscmyUvNxWO6k3Wvyi7Js6qoJroTd2fEDVoX4aPjjgTb0c
         i4xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:content-disposition:mime-version:mail-followup-to
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=mPb1dseby85hPj7kglGTqwJ8qsrN3X6+MxDw+oWIiFM=;
        b=lvSn/8ZHNrlTmpbabr3vw0jvGpmtXXhf7jjq6XW6yLLH4iC/ojveZZyb3PRJuTiqA3
         vuDzBcHVoIj6YztZlU8am9ulYhjfboQcy2yPO+UJk6wVHHjjjJH1GRJbt2ohEIKh6RnX
         VvhTfer/quDKHhstm4AgcVIeLm0HapALD8DUna1hktQQv39VzqB5n7SYMyBw6mq9GNZ3
         jdRxHeBj7S+GCc5n+og8uh8dE1z1saKw61eCAPcZgKXsu6/5hvgdmk+cycB2R9MKw/yc
         UlUG0zo+ZPDa6xA//XAy8n0FxwD42v0JRF5hMMFpLggoXcLj7hRvsQglZaW8kBWbfYUj
         8RFQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@icloud.com header.s=04042017 header.b=ykAU4xYD;
       spf=pass (google.com: domain of damian.tometzki@icloud.com designates 17.110.69.252 as permitted sender) smtp.mailfrom=damian.tometzki@icloud.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=icloud.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@icloud.com header.s=04042017 header.b=ykAU4xYD;
       spf=pass (google.com: domain of damian.tometzki@icloud.com designates 17.110.69.252 as permitted sender) smtp.mailfrom=damian.tometzki@icloud.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=icloud.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-05-02_06:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1011 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1805020165
Date: Wed, 02 May 2018 21:37:35 +0200
From: damian <damian.tometzki@icloud.com>
To: hdegoede@redhat.com, arnd@arndb.de, gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org
Subject: Bug in vboxguest: After commit Merge tag 'char-misc-4.17-rc3'
Message-id: <20180502193735.GA2444@zrhn9910b>
Mail-followup-to: hdegoede@redhat.com, arnd@arndb.de,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599382342256929089?=
X-GMAIL-MSGID: =?utf-8?q?1599382342256929089?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello together,

after commit "Merge tag 'char-misc-4.17-rc3' d8a332730e757129e70675679f2b2a03f1ecf65e my virtualbox with Ubuntu 16.04 no longer works correctly.
The focus on a window for example "terminal window" only works very delayed. Or a move of the window with the mouse isnt possible. 
I reverted the commit 'd8a332730e757129e70675679f2b2a03f1ecf65e' and now works all normal. 

Best regards 
Damian
