Return-Path: <corbet@lwn.net>
X-Google-Smtp-Source: AH8x2248o6GPURxufkwLtrl+oFsrwpTkg+ehNKa/REZn1SEo2Vr2ntFOxrB4HXfIcSX9NZIT4FFd
ARC-Seal: i=1; a=rsa-sha256; t=1519049590; cv=none;
        d=google.com; s=arc-20160816;
        b=RHqmHFdj1ghHISgAdnxJXzuzKktUPFWRGL/SbooPTAcweixc6W42wV5V9sjNdaiIr0
         /XiogobYNablsnywbmA+WdZ4okar85LMyY1nzlSYT+eVl1Q9VaANc2ct3i7w3sNcyDMY
         X0Vh2Sp25MEhG7dYGG2ZesMcRwjFC3Olwo5zr+L2pSakn3rn5r6bsiF3xLUtBM383ngn
         N5qWLnDV1fxISUH67SFGPDxCJKhB4p318zFbmUUT+OSipGEmKfHF12PMrI9Hum0VJST2
         YTSW/o49Y9KkjXlMcggJ0R0rD1h/fu3xqrPKaJVCApb0XveMt/27krsleiW94XsuvsMS
         FKIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date
         :arc-authentication-results;
        bh=G3EFmbST45npL72BWhn8KVcfXEJP0BtLMq70XYW3LZc=;
        b=VMujg12Ku/vI6gdj25yCOZ6Xq6WOLQ85fSRhsZAHLvamwnBp9VvmMobsxTVHWP+6vJ
         h5a/8UAp7xbUKtpeMajolsfMyg+PqVIMmqtQ9DCZgu/+7jk/f49CMEIFyhmjRfnA9jmR
         q9ZJNw0gKNqow/EkrTK6bY/FBiwRSwj6dkCoeTbo4bRS96E4tmPaEPOcmdJ5ACYYCESu
         377rUScHCsPYKUHZRPTpY91xASpAUCRGVI9eHEtuJm4ASaSM7TyqLT/H16aWaL6opi+L
         D8ghrm6SuUvxgjFm6fCsTFKlInaedbVV2DeCyGQzKaMrm1nuB7Zp6fE2YrO2NO7MWAZQ
         6OwA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of corbet@lwn.net designates 45.79.88.28 as permitted sender) smtp.mailfrom=corbet@lwn.net
Date: Mon, 19 Feb 2018 07:13:09 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Masanari Iida <standby24x7@gmail.com>
Cc: sdharia@codeaurora.org, gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] linux-next: SLIMbus: doc: Fix a warning "Title
 underline too short"
Message-ID: <20180219071309.43e841d2@lwn.net>
In-Reply-To: <20180219135550.28627-1-standby24x7@gmail.com>
References: <20180219135550.28627-1-standby24x7@gmail.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592837884320180932?=
X-GMAIL-MSGID: =?utf-8?q?1592838943189613280?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 19 Feb 2018 22:55:50 +0900
Masanari Iida <standby24x7@gmail.com> wrote:

> This patch fixes a warning during "make xmldocs"
> 
> Documentation/driver-api/slimbus.rst:93:
> WARNING: Title underline too short.
> 
> Signed-off-by: Masanari Iida <standby24x7@gmail.com>

Applied, thanks.

jon
