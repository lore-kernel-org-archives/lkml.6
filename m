Return-Path: <damian.tometzki@icloud.com>
X-Google-Smtp-Source: AB8JxZolSiVGPjpBW/rzeDBOUHsrCaCj1jI9qIJExWG3cYX+ntJ+X0/+XPoXV0HefJvBebMOc07k
ARC-Seal: i=1; a=rsa-sha256; t=1525293979; cv=none;
        d=google.com; s=arc-20160816;
        b=xmyQ3Rhmkz8YBxbqy5tVAWkZoS8VHgg/+UZQt5quV7Y7qNEhwiVAgmajfsTfr/27A5
         kNFB19B4vfaAltnVPiAxjrUNrxP82nyi7Zq4MIL0XrkUbZ+/z4JAN69hyMpcDwnx+sYP
         LpZiTXDa2Q3BtaV6SOvHg+sCZDdOeM1iagZwweE1ctJXzN111hvneAA2/5Dyc0UrUpsK
         qDRpt5ZPiaExtO/2HtlkQ3XYDPH1ORjeXxgANTATyIzVWJK8r08RzAdvHAg4+VDmACjH
         PFNaHnvBMgSu2EAqqK3352y9/jG5HVV3DBB6EkzO6pdFhBjSbsXAMyY40VXvV7zwbR9s
         nwUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ldU153s2mGhVUht3ac6asrzwfAieuTrwoCX+vt5vxCA=;
        b=c9LQSmaPlReveDzjz7GPWbQ7NgC5uWZmv9SJOu9KvfCjvloaDTE/879Rr5a10jkArg
         X5//qi/tPDYAGm10YTHnnPp0c4PjPiWSzABCR+2ZXCI9KyzUe38oVm4gm3CWFzuDiZEl
         chidLCy55hHhfNr4bdjLCeGrkqmDQ8Kmq6+ghbP57qnjOWlaiWdvBpjQTkmktAk+RHZ0
         8bZFYMA1y7WxM5KVrggAVmls3GdhE1Qg1Ct1S5RAD+YyqOo9JpnSrrTmx41gmGRzixHR
         Fzvr8+3GB2Ze4ssQU0mI6HeffRSJI4FaVXtjcPlBmXTDrf6TGVaspNDQYyEIJbFE8tvn
         teJw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@icloud.com header.s=04042017 header.b=GIGlBlMe;
       spf=pass (google.com: domain of damian.tometzki@icloud.com designates 17.110.69.254 as permitted sender) smtp.mailfrom=damian.tometzki@icloud.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=icloud.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@icloud.com header.s=04042017 header.b=GIGlBlMe;
       spf=pass (google.com: domain of damian.tometzki@icloud.com designates 17.110.69.254 as permitted sender) smtp.mailfrom=damian.tometzki@icloud.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=icloud.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,,
 definitions=2018-05-02_07:,, signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 suspectscore=2 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1707230000 definitions=main-1805020173
Date: Wed, 02 May 2018 22:46:13 +0200
From: damian <damian.tometzki@icloud.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: hdegoede@redhat.com, arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: Bug in vboxguest: After commit Merge tag 'char-misc-4.17-rc3'
Message-id: <20180502204612.GA2089@zrhn9910b>
Mail-followup-to: Greg KH <gregkh@linuxfoundation.org>, hdegoede@redhat.com,
 arnd@arndb.de, linux-kernel@vger.kernel.org
References: <20180502193735.GA2444@zrhn9910b> <20180502200615.GB16341@kroah.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <20180502200615.GB16341@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599382342256929089?=
X-GMAIL-MSGID: =?utf-8?q?1599386660224480071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Greg,

it is PATCH 3 virt: vbox: Use __get_free_pages insteas of kmalloc for DMA32 memory.

Best regards
Damian
