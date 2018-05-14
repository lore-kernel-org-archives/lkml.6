Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526299533; cv=none;
        d=google.com; s=arc-20160816;
        b=tUhbqElZxyQOWjg702ciBaieMil4MRIoBi4pwjg53IkIzGjS1WR1r56Eu5weziHLnN
         abWqpJH0trTWM6piEwqzGzsXa4GjKBwd8NhYnBkd4yJwwHDtn8v/drAGiVp+HYKguAAz
         hjXowoGRAIqH11wzbptP/EG5k6jtwL4NaWCYtEtQgdOeF4eERsetorZG3jd2eor+z0o5
         mUZL/KwKp/qLga9pvIdDBhZGs/XismAxn+I+k4zO7PJ7RVi85F6bhzOW+uTR5dHJk9C1
         Ic4oyjtwsNpV9/p5w6FEf7GWpO+Knfufl8bQ9jzhRks4nuUOSnMhFxysr4rCUQOIbAnm
         1Tzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=BoZBYbpu0SnklYtd3Hm5+PrgqDEiXtaB/M6Tkj8uKjw=;
        b=zDI1mLyNsSPAmL04+U921GQJmkvf5QbYWbJ22NCdHnrQQto/GY9AIgWBwDCpgtksbc
         5Emjr4evWEBlA/KLznXnSZQPdnyF8FFXCHJhL4lvm0yCEBz/WjFLL4GsDCCBdE2GVKzQ
         aYOvyNyXuvLjtIpq4C8IvtvaEIhyEwX5zxSDsyrJP0frbpD+MJZu2srzsiVjA9HbA4LW
         iBReSiGi9+ixHO27Jb73jmKDzfng2bVBGfBNDHfvWa5nHRa7VvI/+S13BFFEIuSeEBtg
         sJIeJmu9wxU2Yo9SfRYefsAEbAh78dlfdY7m01oYFT+QTWifNdc2mTFsan5+B/q9iLT5
         5aog==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZpGgPZqMSznXt6qjZTNThGSzHC4yVAW0daR4M43zkpZyta1kMirkwm0NhAaN5HBCZXSaYastQ==
Message-ID: <5af97b8c.1c69fb81.f65a9.57a8@mx.google.com>
Date: Mon, 14 May 2018 05:05:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.4.131-57-ge33795f7a573
In-Reply-To: <20180514064754.853201981@linuxfoundation.org>
References: <20180514064754.853201981@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/56] 4.4.132-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600421343968501935?=
X-GMAIL-MSGID: =?utf-8?q?1600441059498649483?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 87 boots: 0 failed, 87 passed (v4.4.131-57-ge33=
795f7a573)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.131-57-ge33795f7a573/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.131-57-ge33795f7a573/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.131-57-ge33795f7a573
Git Commit: e33795f7a573385b26763104b63355823de20e4b
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 40 unique boards, 18 SoC families, 14 builds out of 178

---
For more info write to <info@kernelci.org>
