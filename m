Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519705086; cv=none;
        d=google.com; s=arc-20160816;
        b=i7saBcQm8ihLmb3Ezh00TsZT/vqOGhjKQ0wdp/JKZMC5LxBM0ZPOVGetkkZMO5tth4
         yaRitQee6wBxq1+qQyjq5qd7DhnKdKvE73AcCrBnAO2logjMJJGDwOx7AiicY23kZjEe
         fMigsVHRAuQdSOXQ91YFZaeahIWoLxq0BWRUdixFBiXEiS10+K4dtsUxAC6nIdWlBc4g
         gSpfDPo8qznNIOELRbKas+y1fezz10odsF2WjwEUIt/lRlTUeZJxzHEWFCmrID32aZxn
         LPhKuhmbI0/xlYodToBdlsqjZu3uj25lqZWWq/lCUdlpDXPoUSHfSfleQtsRuaxBXBLi
         SPVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=BIVr9l7/wYxoy8r/scsLjYRUYACrTwGqo9CbwRhr/cM=;
        b=mZ0WYHSOeLXpSs0saEmoQ1+sNsOSGrRHcZZ9Mz3xVqnTJ2dP/66YkDKqm2U9aAe1uG
         W5w6tV40Gaq/1UsJPh3rtczX+kMtEclWlF76drCPgJAYvmhXvUfvU7VmPXhEHQ3dBF8d
         4BvlAV6AxSpjyfeKouy19a+pDAQ1/Cosz9tO/sOOLSXuzsc2X81h57rUjjEkuDUi/7ix
         nWRW6xFOZ1PKj+bUZelJ9JZk+aIej65RWfGyxXwKkw63QaxlGcaxqRFy4pk7dZA36Wc5
         A9W9+R3KaaNwRqvowX81/jq6A8QgVSH9u+z9+i7jiRzDH8Cvy/dzzXgvYto2wIJUV4Se
         U6ag==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AH8x224cCmWfJLz3POTicn2p/4p5So7p0WydUbMF+6J+8u/Bj0Ry+tbN+Y2DTw1/xydsZyJEiwetvw==
Message-ID: <5a94dbfd.ccaadf0a.3ce5e.8d4b@mx.google.com>
Date: Mon, 26 Feb 2018 20:18:05 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Kernel: v4.4.118-23-ga6c6a3a6b562
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
References: <20180226201558.681421374@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/22] 4.4.119-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593496055106924305?=
X-GMAIL-MSGID: =?utf-8?q?1593526280649400660?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 87 boots: 0 failed, 78 passed with 4 offline, 5=
 untried/unknown (v4.4.118-23-ga6c6a3a6b562)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.118-23-ga6c6a3a6b562/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.118-23-ga6c6a3a6b562/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.118-23-ga6c6a3a6b562
Git Commit: a6c6a3a6b5621c2507038cecf42c46727d327048
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 45 unique boards, 19 SoC families, 15 builds out of 178

Offline Platforms:

arm:

    multi_v7_defconfig:
        exynos5410-odroidxu: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab

    exynos_defconfig:
        exynos5410-odroidxu: 1 offline lab
        exynos5422-odroidxu3: 1 offline lab

---
For more info write to <info@kernelci.org>
