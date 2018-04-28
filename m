Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AB8JxZr2tC39NdA0gwROdFEtDSMY7LzwLmo1Oyc8rtw8n1guyuLOwwnSaYST0jPEoxUdl/VZ8fxE
ARC-Seal: i=1; a=rsa-sha256; t=1524884573; cv=none;
        d=google.com; s=arc-20160816;
        b=nkoBPhRE5bQbZz+1O6qY4perSdFuqaduou+wYnvNaxM2iZ/ZF7enHBnMKKWxQLR4JC
         gnOYZ4/Q9C0eME+wgdnllmYKxGWgk4LCUP8EFkA5ozmI0mmSx8bjIPDP6xk9MYinUS+Z
         uZrGIe6Es/WFYZeUmk1/a/Ua4dDWNufQeENdApRF+Wjwu6LveA0sDdSztjaYldFvTx0Y
         8iwMLBcJJZIwJ2OFYIgwz87FehMsRFy0aVhIUyhYNTo9c99DcoA+KwBOsg8ifM/LBVYM
         NcfAZ+hldhilWygl5R52Q7elhtDXvmglCLj7Ey4+HdCsc7KX2GrXGwpx5bxSlN9nzmI5
         cY+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:cc:to:subject
         :message-id:date:from:references:in-reply-to:mime-version
         :dkim-signature:arc-authentication-results;
        bh=lL1USNkIylN/7lJU2CgsDQopms8APOJ1BlIxjayHhaI=;
        b=zKuK/oGWlXIc7t3iAjF/ycDggagerTgXo0/O5+yPi/shFcjENr2kxT5QtDOTii4WGQ
         fUP5aOZRSlUmmlvDix4Ko6wY8x0v6gIldNnX100XDfRGUf799tUQ49A+SVSjmTcHCR5S
         jEuSPyjgX5IiqaCUKqG/3r2Htg3x5+hy3kYYkquJKjDGcZ+1H7jTeVuARtM+kfXPOYu+
         p5oEH1S6BtrjNnwDgQpoMwgx03VUqFiCnexEnYxP2n3Gejzsp9yMkUWsw3kZnVX4yAPZ
         PSc4c4w68e1vV/g0JnNEuX98+enYhU/bNnQQ/4e168Jfxu3uGciBghGuqZUhWAsjcS8p
         n1mQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=M4ufroHm;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@linaro.org header.s=google header.b=M4ufroHm;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759374AbeD1DCw (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 27 Apr 2018 23:02:52 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:40523 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759330AbeD1DCv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Apr 2018 23:02:51 -0400
MIME-Version: 1.0
In-Reply-To: <958d61ac-f70a-80b1-a657-59fe1fd1d369@infradead.org>
References: <958d61ac-f70a-80b1-a657-59fe1fd1d369@infradead.org>
From: =?UTF-8?Q?Daniel_D=C3=ADaz_Rodr=C3=ADguez?=
        <daniel.diaz@linaro.org>
Date: Fri, 27 Apr 2018 22:02:49 -0500
Message-ID: <CAEUSe79+t1D4XUaaVi6vfEvDA=pMkGqag+_GyC32WcEbTXamBA@mail.gmail.com>
Subject: Re: kselftest archives etc.
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        fweimer@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598946970016814291?=
X-GMAIL-MSGID: =?utf-8?q?1598957367204314969?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello!


On 27 April 2018 at 19:17, Randy Dunlap <rdunlap@infradead.org> wrote:
[...]
> so I looked for an archive of linux-kselftest@vger.kernel.org.
> http://vger.kernel.org/vger-lists.html lists all mailing lists and
> (some of) their archives, but none for linux-kselftest.

For what it's worth, as of last November Linaro is also hosting a
mirror of this mailing list:
  https://lists.linaro.org/pipermail/linux-kselftest-mirror/

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
