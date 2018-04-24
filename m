Return-Path: <robinmholt@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524590934; cv=none;
        d=google.com; s=arc-20160816;
        b=M0SiO50Ya9u1TZOEX+y+n7pg839qoiVKAFHJyHAqEqc4Eq3L/cm3e3+eSxuUPXI8nY
         jOsKhdB8dn9kqlQxgucAqLYebDOHpfjA3r66KOmSzYoJvXndZAnwg50lL4nAv7ISdlcO
         mmsutwEFobYzXA5EJRT/bGgyulK01geVjTaTnqGpmpYHc6cmwao14bk01RPV2a+hFRSt
         GAFcmimpZvucaMqDJlZbmET+fVMeuJ1A2K2fLcJcaMug6vt8CQWE4xDWU5szkOvZ4+QV
         h3Nr9GsHS4cCqqUf7YqWb+j3JS/LGfKJcTQ8X7A1PbjMiWo4zi67jLDpVMAgFTphn4Jf
         a7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=qDW5DBECAAVPtLR7WEVos0DJQvazC/j10m8je//vSXk=;
        b=oFRCElerg94GhvKkwxgJzqy0WZLNnOqgCZpKXlRM61RwnyHtUXPWZpiCmxDwiVCAzg
         iHwxWv7WAEFqAZrs9K+MKCZbuZPVEHFoclNJKXmyYpCE6Rc7Tcbqb1GaeoPXrF5gEdVP
         WPm+Rrh+4MWfirYwfHG4UsNhQ54JAqvZViAoGxOLraEIZMhwiUprzPPAEQeFI1W2oquO
         yiEAk+Qf75jFtoSQHb3EqUPqEyJg0GWmNfQ2Dbvb51aeQjkmbKVJvmWTHedbo3eR8cGn
         NlC/nhJV9gbQbE9ix/Eq60DkdxGFDwgbm8sGW6GGBQ95qYY3cm/trP7aE0kQn9G30Sto
         Es2A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Cd7stl1W;
       spf=pass (google.com: domain of robinmholt@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robinmholt@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Cd7stl1W;
       spf=pass (google.com: domain of robinmholt@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=robinmholt@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AIpwx4+npucdKdAoCWs5wQhZBTRacMd0iI7V/aYNYAvoEiCQwUrP/hPXPayMTslsiZfyBiI6+IxsZQc7GvcYen+vvYE=
MIME-Version: 1.0
In-Reply-To: <20180424131556.2961-1-luc.vanoostenryck@gmail.com>
References: <20180424131556.2961-1-luc.vanoostenryck@gmail.com>
From: Robin Holt <robinmholt@gmail.com>
Date: Tue, 24 Apr 2018 12:28:53 -0500
Message-ID: <CAPp3RGrOqkd-a2Pbu3rRjfv_csUCfh-Fmx=HB8jaT4kwndc3jg@mail.gmail.com>
Subject: Re: [PATCH] sgi-xp: fix xpnet_dev_hard_start_xmit()'s return type
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Cliff Whickman <cpw@sgi.com>,
	Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598633549415004585?=
X-GMAIL-MSGID: =?utf-8?q?1598649464292506214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Apr 24, 2018 at 8:15 AM, Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
> Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Acked-by: Robin Holt <robinmholt@gmail.com>
