Return-Path: <michael@ozlabs.org>
X-Google-Smtp-Source: AB8JxZpvWKOErdq0EJDBX3QcMuC72tit4ar9OSR9sziibnD8dhZbMcMlS0pYper+aRX3t06sw0V5
ARC-Seal: i=1; a=rsa-sha256; t=1525961207; cv=none;
        d=google.com; s=arc-20160816;
        b=J2J3U6zwpz6Vh6xdRBlunHXPwQsyBJD5J5tcKYnOIC4/0aDRTHYoySHEzDvyEHZT5+
         6l97Ye44hcf+LH3li0XUgbeuc3dspMbMTvG98BSYGIoxwmeXiFB+q4UkHAeoniE7mXe4
         Nh1zSuBCI+t+0GOLyNmJAWGSvJ2Snj5Ejc08g5R94fM//QFhbbWdt40Eovq99X7Px8Qp
         PnKN1C8iJSxzJcSCfuR8D0wp9KwWje5qKTH3D7L/75004xnr+8tMJLK772Tjbdk4VP+9
         9jpnqL3azCKsdiA1KEL7MMJOzBhNbrZfrErmfLJoSH+dKtkig/DmxKiru1iPJC83wRwx
         Ut5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=date:message-id:subject:cc:from:to:in-reply-to
         :arc-authentication-results;
        bh=ydpRhX5/7VC5Dt+HskEylf8EsEDtwhteFExRt9lv6vQ=;
        b=kL6ghlV+UyA9wJt+v9aLb813LqAR6LZfIv2RXMdNw0RsgOHzBdjAJHy4TQWGSfNxQy
         M7fvxzT+wjOiYefcflVuxEG0HJOS/TEF0JbLw1BNlWOIO0bzLWZ4IqhQR1mLdwOvd+uh
         eA0F1lQmlV+SLhO8QrJKAcAfsA7fLpTaSYFhgJhbjDj/i39XUiZrL5CvTA7ff6u3z3KK
         YuWRYfgmDxg/LQqMPbG41Mtjl573Zlf/qD2wgXe9n3Emrkh/WZ39f9HcdX5a04v6upMR
         96v6Eyse0p5/DAvNRqVxNbJBoIEDbcbDmRPLTMrWyJYGEgULBfE4CUO98umTeH9ickUY
         SM6w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of michael@ozlabs.org designates 203.11.71.1 as permitted sender) smtp.mailfrom=michael@ozlabs.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of michael@ozlabs.org designates 203.11.71.1 as permitted sender) smtp.mailfrom=michael@ozlabs.org
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a84813f5bf2948c2a2947b0d68456204128ae28a
In-Reply-To: <20180507142019.32669-2-j.neuschaefer@gmx.net>
To: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Benjamin Gilbert <benjamin.gilbert@coreos.com>, =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, "Robin H. Johnson" <robbat2@gentoo.org>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Joel Stanley <joel@jms.id.au>
Subject: Re: [v2, 1/4] powerpc: wii_defconfig: Disable Ethernet driver support code
Message-Id: <40hZll2TTNz9s1p@ozlabs.org>
Date: Fri, 11 May 2018 00:06:42 +1000 (AEST)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599815401906137196?=
X-GMAIL-MSGID: =?utf-8?q?1600086298748619545?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-05-07 at 14:20:16 UTC, =?utf-8?q?Jonathan_Neusch=C3=A4fer?= wrote:
> The Wii doesn't have built-in Ethernet and USB Ethernet adapters are in
> a different menu. Disable CONFIG_ETHERNET to save some space in support
> code for Ethernet drivers.
> 
> Note that this patch doesn't disable any Ethernet drivers, because they
> are not enabled by default.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a84813f5bf2948c2a2947b0d684562

cheers
