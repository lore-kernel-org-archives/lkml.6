Return-Path: <maco@android.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522236881; cv=none;
        d=google.com; s=arc-20160816;
        b=ZrzjEeAlseNQ4Ey0UiL7GVubG0nGL9ks8KRuuJl4+wwWcYwBatnRKZsnAOi1Qzp7HA
         1G+wypYZTN2v6ackFZGphwpztLf915ZQ91bk1gd55KnnjwVlDjb3NmrQE76VrYfecZdp
         jSul8wfJ+1oblyfv+HAQZ6ctarNUNnkx6bkCwdb9A1F3UCpOEV4B3sJcvzQBFWheV45c
         +96R2/5ntgC7T9g145l4qCi9aH45SNj1K+CESD+Dm61TftVRffiDBZo6mApmvH6N3mWE
         oLmjNWbIoEIhEsvWLYtodR5sy3ifXY5zc2PVAZwSAPn43o2GJJ/L+wIHeY1BgbDlq1in
         6BHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=6CbsJRdJGsdo4KXIsxDzdwEc91A+0Q9uTLK+8IuhUvA=;
        b=rPg7YU8zK+quebTYph/pt+60K40+xTjNCuLfekIuYYIDgQwtinJ8SMxs864a4RgueP
         m29VFgW5/ngncyCjJINhMmJYAjU4sNljWH2uOd0hPGS2fovKSvwaA6p8l6eosHHqMh69
         1dVEFG7i8UyXvNyRCNyvuzQmBzoRf5F5ZUmyDLfaQ9zt4kLrC+4c4GZCWI2kF2EQh1ZZ
         WARzMhF2EeEY+BCZZWbgED6RSicU1p3MAmgho2gwd7C8lW+H/D8enMgKrAUy+zFhzsw7
         F8ulNWg6rCjuKlQAjfvjtndNE/9nL9hJevrxLBdxqbY1czO1kcxjf2q1aHfbfF8gyDR2
         /LGg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=UsPSR4cg;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@android.com header.s=20161025 header.b=UsPSR4cg;
       spf=pass (google.com: domain of maco@android.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=maco@android.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=android.com
X-Google-Smtp-Source: AIpwx48FAK2JwXMVM5y/Zp0wdwN/Cj8/DlQeuKAiHHRpJgT69cjzx90xomXEIBn7UZVPXCB7kOEkqNeBllnU/ILu3jI=
MIME-Version: 1.0
In-Reply-To: <20180328112921.GB26219@kroah.com>
References: <20180328072903.155938-1-maco@android.com> <20180328081921.GA14201@kroah.com>
 <CAB0TPYF_zs=rL5qQ=C737rBVx_Z0utaihJhv9dnRqvpJ0sp7Hw@mail.gmail.com> <20180328112921.GB26219@kroah.com>
From: Martijn Coenen <maco@android.com>
Date: Wed, 28 Mar 2018 13:34:40 +0200
Message-ID: <CAB0TPYF_=P2cMhb+KAGiS2kk9LvDKiZ5dRQdr-O2oCAsXVE8GA@mail.gmail.com>
Subject: Re: [PATCH] ANDROID: binder: prevent transactions into own process.
To: Greg KH <gregkh@linuxfoundation.org>
Cc: John Stultz <john.stultz@linaro.org>, Todd Kjos <tkjos@google.com>,
	=?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
	Amit Pundir <amit.pundir@linaro.org>,
	"open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>, Martijn Coenen <maco@google.com>,
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596165622257812617?=
X-GMAIL-MSGID: =?utf-8?q?1596181060665162160?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 28, 2018 at 1:29 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> I can mark it for stable, and then when you get the "this did not apply
> to this tree" email, you can send a backported patch to me so I know to
> take that one then.

Ack, thanks.

>
> thanks,
>
> greg k-h
