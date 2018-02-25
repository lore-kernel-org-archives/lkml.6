Return-Path: <mforce2@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519523596; cv=none;
        d=google.com; s=arc-20160816;
        b=wCQcM//IRel1XK1V9sbSCDPNCBQccvCSGjM05Y0BaIi+O/4Vy9QI98OFDZVELOdATs
         i0ZL970zmKCaHytfQg2VCDK+0CGwpZDtYwZPAVDawoWkL0msEIuqfe0YldnsahEtFKsM
         +G2REANlGpq923gBzeU+1BYSy5QLTf/5QkNIV47cqGQznXeQhIziNvZc/XlftlQjEnfU
         UTAK2rqwENWGsq99omBGWClsB5KSpa7u+2ZBI6s92WUn/2gi2RcXIOAH8WMdZoht6QMs
         Fvb7yV9d132Fq48W9rMxLjbmmbSaUEpw+1E/rT5aEJAa/89bJqCVQJfKhHRldlBkRpl4
         mZ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature
         :arc-authentication-results;
        bh=zfg5cquXO6MH7Qb/gbZMf8LSW0KcwqRs99KJ/WX2uRc=;
        b=bo+Sx/3NMHk9JE+ANeVQfx3hJhcACoJmcEVyiJJOmswaqsXa4jeh+07CiTolBL9f5G
         u84hXyWusXbR6LZgzfdfZ9BZVLzufpjfUDzfWTkvA6HINjbAMAyB4HemSRDP1ygUbRBJ
         7BPTbmf73BxUPC4r3r0156Sqds3JFm81ONQ1ya9jGbToOnFbm4BKDVoRlQxT2NbNE95a
         ow3ywLkI/cq+Srpv1u9FwSq5rOxBn0M/uGVMQq3R8LTqGUwHXC66bQxg/zXThnsIpHoN
         s9IrJyTFOErm51nsgh0wQSwgIm1LXK2u4k312+19GvM/krNMIQEB8J+ph4tVg993fjyc
         PZlg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qSF3skl4;
       spf=pass (google.com: domain of mforce2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mforce2@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=qSF3skl4;
       spf=pass (google.com: domain of mforce2@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=mforce2@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsxvZAaDFFjcZzaJJSEy7VrXEvp1YtnZru1GPKMNhZMjdFAMtReS8qcFTklWaDezayp/VdP0dA4zgqDU8po9dU=
MIME-Version: 1.0
From: Marius Cirsta <mforce2@gmail.com>
Date: Sun, 25 Feb 2018 03:53:15 +0200
Message-ID: <CANO0Vk6d+cqo5fqtwPUp6e3DugV4--BbT_k-FNTgSkL0N635yw@mail.gmail.com>
Subject: Logitech webcam USB audio breakage during the 4.10 merge window
To: linux-kernel@vger.kernel.org
Cc: nx.or.die@gmail.com, gregkh@linuxfoundation.org, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593335974570800484?=
X-GMAIL-MSGID: =?utf-8?q?1593335974570800484?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

 I have a problem that was previously reported here:

https://www.spinics.net/lists/linux-usb/msg156999.html

 It seems that with the 4.10-rc1 kernel a regression was introduced
that makes my Logitech C310 microphone record a distorted ( chipmunk )
sound. With the 4.9.1 kernel it works perfectly.

 Immediately after I plug it into the USB port all is fine but after a
few minutes this problem occurs.

 Also if add this the kernel cmd line :  usbcore.autosuspend=-1  it
also works fine.

 One other thing that I've noticed is that if I make the sampling rate
22K it again works fine so only the 44K and 48K sampling rates have
this problem but unfortunately those are the default that Chromium for
instance uses ( it gets them from pulseaudio )


Let me know if you need any more details or testing.

Regards,

Marius Cirsta   ,

mforce2@gmail.com
