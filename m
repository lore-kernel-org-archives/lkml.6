Return-Path: <harsh@prjkt.io>
ARC-Seal: i=1; a=rsa-sha256; t=1524561578; cv=none;
        d=google.com; s=arc-20160816;
        b=kXoUaCraJefxP6BcrhrVjIYgDaNqvr2k/dk/78mP2+InquNq4X51HyovFmiEiXJAu2
         fwfS5ryOqffRYqqRSEz5pNLKU/FSA3K3iz3fT+9rzVoNCAHM9dr/S5af/czipUUJniSw
         dac4pFYeqthnrPfQVUg8T3xVSFGRpUad7nEIomiCcoyFrwV9tmYEoA4tVh+vZuTUX0yj
         vT5DG/s7f99HGttgboy/ZujUDoabsNPuSzK6sXyHWiK8jOwTEQgnGYoOcrg7eovKhbMI
         zm6EI9GtNnJBAoS7wS7UNZU4xEcvOwdiH038/mEV2t6KodtFsschoF9cPbKlFDn9gqsg
         WIIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:from:cc:to:subject:autocrypt:content-transfer-encoding
         :mime-version:references:in-reply-to:user-agent:date:dkim-signature
         :arc-authentication-results;
        bh=0IMvfTkFyHsnWS8frUAaYwktv44yGXecBYHP1kJiPDg=;
        b=VvZs2Jbej4ex6OSvfc4B65a0EWBLmOyaO4j210eSWfwML9NK1maH7QyYWvz4pOAgld
         sEJ7ecAgPYV8GTgKzATWUoWSbacIxNq0ibCpmNqR/6bElJxUvpFSZooYibBvOtuz2XVR
         O84hcMI0E5HkkhCp9mzhAph8Mf/EX4+MmPk35Hcohuv/J4JNyunYAX/Ag7K1LbD40xW5
         N8CrAbui9Y0SJMxrFcqYDXIcn1NGfaI3a1bFHWo2GkPOEIClcfakkAgaJssqK0k76E93
         QbS/31inIE7r5Teduu1pPmTHKp9vhZL82aHI4R/AkX7zlu1hwFtYoPCJaurX/a+NUjoq
         9Ltw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@prjkt-io.20150623.gappssmtp.com header.s=20150623 header.b=zOX4qdLR;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of harsh@prjkt.io) smtp.mailfrom=harsh@prjkt.io
Authentication-Results: mx.google.com;
       dkim=pass header.i=@prjkt-io.20150623.gappssmtp.com header.s=20150623 header.b=zOX4qdLR;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of harsh@prjkt.io) smtp.mailfrom=harsh@prjkt.io
X-Google-Smtp-Source: AIpwx4/ue13qHeY8w2wwd7VzIU8VW8PjDR7aUj5c22meszEsUoapnAYZ59IJJp3ilZw/of5h88uiXg==
Date: Tue, 24 Apr 2018 14:49:25 +0530
User-Agent: K-9 Mail for Android
In-Reply-To: <20180424085206.GA2937@kroah.com>
References: <20180424085206.GA2937@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=harsh@prjkt.io; keydata=mQINBForuUUBEADNrWLYhW8qjO6GmfU32cqU
 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
 GOzuzn9qgWR/VAqd9BA=
Subject: Re: Linux 3.18.106
To: Greg KH <gregkh@linuxfoundation.org>,linux-kernel@vger.kernel.org,Andrew Morton <akpm@linux-foundation.org>,torvalds@linux-foundation.org,stable@vger.kernel.org
CC: lwn@lwn.net,Jiri Slaby <jslaby@suse.cz>
From: Harsh Shandilya <harsh@prjkt.io>
Message-ID: <68F3F030-D8D7-4778-A4E2-5FE32C9F247C@prjkt.io>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1598618682267163461?=
X-GMAIL-MSGID: =?utf-8?q?1598618682267163461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 24 April 2018 2:22:06 PM IST, Greg KH <gregkh@linuxfoundation=2Eorg> wro=
te:
>I'm announcing the release of the 3=2E18=2E106 kernel=2E
>
>All users of the 3=2E18 kernel series must upgrade=2E
>
>The updated 3=2E18=2Ey git tree can be found at:
>	git://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linux-stable=2E=
git
>linux-3=2E18=2Ey
>and can be browsed at the normal kernel=2Eorg git web browser:
>	http://git=2Ekernel=2Eorg/?p=3Dlinux/kernel/git/stable/linux-stable=2Egi=
t;a=3Dsummary
>
>thanks,
>
>greg k-h
Status same as -rc1, no merge issues and no regressions=2E Thanks for the =
update!

--=20
Harsh Shandilya, PRJKT Development LLC
