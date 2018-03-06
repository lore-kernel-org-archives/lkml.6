Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AG47ELvgklBeoCJRnx48xJVwWJn+StRMnqfgIZqpThTR558Iz49BZModlHyGChYorYThbZKKTcCH
ARC-Seal: i=1; a=rsa-sha256; t=1520358533; cv=none;
        d=google.com; s=arc-20160816;
        b=V4BXGvZcD2ojIFkm650JYeI6Ifjo0V88Vm1qvkrVWY1YYOUrye0eFsKefJ9BSyfH1N
         NB+9xTDdhS8yJAxuwq91Jh6wkQxe5pYy4rfgANLMLFjLTgXMb+js0XGv4Lja7Eoqx8iv
         rKEBH5Rtg4x3YGkLwpRIfIwH5rBl4uqNTJGH/kgV3SGTEoA29fX77EICSCwcJ6cEYseB
         aY2ckBKJT+IozLR/WazZXdbQmoAurZUVLb+uljgmxqjsg3FbNmPOZZPWYI8X7ypYvN86
         J0Ly5+2fMu8/P/Olf9Ypwgt19Ot+OsnyFxrxenpLeGWFmCaoQruxAaP3PdcHIZCAczCA
         Zcqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=AqLC5aHw5w/pgGCkF09XMWY15rtN2vyjdGrRuTkyHCM=;
        b=y13nV4MMVT5pCvUP5rySLcX/zAHrVr2snZxLjXnooN+TfxNfiROqmp65XfIw9VZzJz
         H2oVtz8hOtGVRfX5XcPVN0q5Yd4sQKgz6owiHafu7+2PPVxTbXLCPBbLDbWOYy/zR5Is
         YWKE2qETnu+U2c40xfNuXh3/cn6dutQ9P9DdL1bNvdlXCKeE5FKg49A0rFeheK01q2Lg
         gx+TYqphKfcqKRP1MJHzgLV2Cy+QxZUfCnqsKc5G6EWBbDCuc5Jdi0bXdj8RW8TAdblj
         rUMzc6xTn8jgt4HIQiaE+z6pf2CIiu04wWL80udDfic3Llev7Xe/yCIYByABqc57oSPs
         GPaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Tue, 6 Mar 2018 10:48:51 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] documentation: add my name to kernel driver statement
Message-ID: <20180306104851.41f31ccf@lwn.net>
In-Reply-To: <20180306174628.GA9333@kroah.com>
References: <20180304201814.19641-1-aaro.koskinen@iki.fi>
	<20180306174628.GA9333@kroah.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594039683394131327?=
X-GMAIL-MSGID: =?utf-8?q?1594211469998040558?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, 6 Mar 2018 09:46:28 -0800
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> Jon, can you pick this up or do you need me to forward this to you?

I've got it, no worries.

jon
