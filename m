Return-Path: <hadess@hadess.net>
X-Google-Smtp-Source: AH8x225OhRbQ0Z8bNlvI/UHfssQU/LQGfcn6+51n3k7LuZDmsFt6AinONxJXx6JE6pYZ1vPeR6Vl
ARC-Seal: i=1; a=rsa-sha256; t=1517933304; cv=none;
        d=google.com; s=arc-20160816;
        b=iUKkESwANwiS+MojeBwozGTMY2yBdhNOrOu6IVTtsnyN6y5urNEeEgj43l9C2mNWtM
         20cY5M8e7IFZxAkbOMQJxoHUhUMcsbpw/giGj5z6NTGOIxirnyFgoiWAg/4HdJJR86hr
         VNue8FwjwqVUNzQNPScYaNAooHxvk0EihDplYlK8v79JrxFCqUw5d5pf0LDkOXFjtZnZ
         Vh8kc1k8ea3efqFu9Fl/ta5f5G0NYqgBcBQtRqrSEiTyaJOwloXfHG0BFnSgEJsqmQdx
         K2PkqzocflB69KIoHi+YOQZaceMhssB8alioSsSkRwMK7Ty8fxa6HzS5fmJnRxfFaB2k
         SDzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:arc-authentication-results;
        bh=qpgxlRLrqackASONzUwSwpPQidjp1tjwX7QT9HsD9Lo=;
        b=kxmONOgNTBL8+RaZFne4YtKXKQaQXIkICsknCh1D7qqbDsxufcQSIFdw3HQpRo1Hhi
         eNOLRs7C7jQiDb0btPUTGBBvWNiChH+eZnB4rgDwFxZTIAxsME4j5btBpAx9qeCU5F4J
         PBK+A9DuP5PXP2WOCPa0Qy4DtXlSDex2QAUPTJONqW/I+SxwQt4IS36LOJQQEcqOlHkc
         SZLTUDNo6qp923KxVwmKoQ1dLM+6/Iuor3G35CnvDgLaTVLSE539bmzSb8zmRwXlkp6x
         kHDyCA9uOGwtk7pyvazsQPRYxRcKQp1JNR2WFbx5pr/HmNsmU+115itetowaHEL1Wjty
         NvqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 217.70.183.197 is neither permitted nor denied by best guess record for domain of hadess@hadess.net) smtp.mailfrom=hadess@hadess.net
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 217.70.183.197 is neither permitted nor denied by best guess record for domain of hadess@hadess.net) smtp.mailfrom=hadess@hadess.net
X-Originating-IP: 83.155.44.161
Message-ID: <1517933300.2557.81.camel@hadess.net>
Subject: Re: [PATCH] Resolve RF Type mismatch
From: Bastien Nocera <hadess@hadess.net>
To: Kangmin Park <l4stpr0gr4m@gmail.com>, gregkh@linuxfoundation.org
Cc: hdegoede@redhat.com, justin@jvreeland.com, Larry.Finger@lwfinger.net,
 davem@davemloft.net, aishpant@gmail.com, joe@perches.com, arnd@arndb.de,
 ianwmorrison@gmail.com, devel@driverdev.osuosl.org,
 linux-kernel@vger.kernel.org
Date: Tue, 06 Feb 2018 17:08:20 +0100
In-Reply-To: <1517932633-7832-1-git-send-email-l4stpr0gr4m@gmail.com>
References: <1517932633-7832-1-git-send-email-l4stpr0gr4m@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.4 (3.26.4-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591659081270914487?=
X-GMAIL-MSGID: =?utf-8?q?1591668433193548639?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, 2018-02-07 at 00:57 +0900, Kangmin Park wrote:
> From: pr0gr4m <l4stpr0gr4m@gmail.com>

This needs a commit message. I don't understand what the code is trying
to do.
