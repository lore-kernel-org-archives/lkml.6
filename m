Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1518197785; cv=none;
        d=google.com; s=arc-20160816;
        b=GtARSNKMU4v7g55GieHp5PPHDWyxmshET/kGpq3F/fc8kMoTqWPG76oTOKTLy/6CV5
         wwR+auBUyXO8uraMUPcg9k/LH2cboHADNovi3L4t+BvyqxdPWU6SH210jV4DybMefYJ2
         +Q3lwlNtTqLE7owD5PHBwO2wwzO731J0qQOCkhIamu6iS0QHsAh7tTy7drlxdxLcKg5W
         QePpW7yjJPXvJVyWwY62CI91eSfgt4zN8I5Pcq/SuMK+KGYCXuCKaFeJYOrwB0xNGLem
         CuV6+SuarTgnlRRMMajKzk7byHCytH0fv7SghcpbINDKdyQ7bQ0CjaS0A1Hao+hrckdR
         tLog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=VmmxVc6rBxerNdpOjaHQsnmKjRgFiGGB2Z1330KcJSQ=;
        b=dNeqsSTWTEPi4rmQhbqRoQQRkNuKLkQ2M6lueLZE8lCyVA7Pa3N1gCsOkQVM2PwIIg
         NPqkUk6KSS9wgoZnvC/EjFQ8Q6WMuEmJC35b60rHDIpunnzgrmw+Fe2SKnGBdXOuMMdp
         xgLeexOkTDYLXKWbh0tT7Bh3rT9THrZm6EM4zCoeh/jfQb4r15MdvZmTaxBcWXYaUExQ
         38rTfMHqtktSa1rQ6enY806a9IEThaIoTcjKYcfvAb+C/tlPJPIwitasApRX0VrR0DAz
         GIv1QuWxP3Vzpor2fDYLF1HNxxbCuPoermaNDC06sW8nczS/5EXQAl4YNRCKl2UV7NW7
         /nVg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x227NyAmfPVYLB7HuWDnZnHpEGxObGrJ0nntf0d8cDk7oyO8oJsHXhsSxIVCrO9XOsRZg5mMXpQ==
Message-ID: <5a7ddc18.d78bdf0a.d9bdd.32c7@mx.google.com>
Date: Fri, 09 Feb 2018 09:36:24 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Kernel: v4.9.80-93-ga5ced8b8b31d
X-Kernelci-Report-Type: boot
X-Kernelci-Branch: linux-4.9.y
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180209133931.211869118@linuxfoundation.org>
References: <20180209133931.211869118@linuxfoundation.org>
Subject: Re: [PATCH 4.9 00/92] 4.9.81-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591930948104986764?=
X-GMAIL-MSGID: =?utf-8?q?1591945761511348699?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.9.y boot: 103 boots: 0 failed, 103 passed (v4.9.80-93-ga5=
ced8b8b31d)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.9.y/kernel/v4.9.80-93-ga5ced8b8b31d/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.9.y=
/kernel/v4.9.80-93-ga5ced8b8b31d/

Tree: stable-rc
Branch: linux-4.9.y
Git Describe: v4.9.80-93-ga5ced8b8b31d
Git Commit: a5ced8b8b31d616ce1a8284d1756f733646d7f1e
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 56 unique boards, 21 SoC families, 17 builds out of 183

---
For more info write to <info@kernelci.org>
