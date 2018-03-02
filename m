Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1519999137; cv=none;
        d=google.com; s=arc-20160816;
        b=Fit9/zsxHHssze8MSNuz1Loi0XPJ53G0ksg38I8N/cbJ/l3C0FOkH5usXLEUzarZxt
         hEqmle1JNIilRAywsUCWW0EUXKFRqUDu+/DIJUkM9mJl4MF7DIlViopGGHLztAztF/Rd
         Wqu4SCd9B05xCEZtsjykoumi+D42C85vM9MONUnGB8FZvr7WI57RcuGaiEjZifeq/VE2
         Dqj+RH0ktMQ5ZAoKgHT/+RjVTmdC3uSt6S5QScJDl8ilKujd5a1C9DDPfjb4c+3gcoEi
         +BiE1Odj+8qA4HjKQzI/7hBji0cbkTjk5B9r65R5XCNWfxMN083Bse4uuXo4WXbk9mFr
         HJjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=wNm8Uz+EwEFcdsj+lt0KXD7xGis2rhDGO2PFu8m4UlY=;
        b=TfuNRAQp1YonmAKv8283XkY18xHUsTE+7p102RKoxCOWxWB15lIYZfgREZcTJ8xdBg
         drdUkCIQuLWv0/6Fruw8WwNWCCyT3mF6yEr7wKzPVWvS1agUTmlnL/ZzbAdCKJc15uze
         dvpg41FkfWe5ea5osHTk1d3lT1Z/ztWWyiLRHE4uNRRuCZBn6sTKX15EyvZ5opV9nqDi
         LPLedgWVQFyGiNEn26/VnP2L/i82flmmxzIAbWBvaWR7EeUPAD3vS6Tuwli33vw3fgyc
         b7r7+p8CsjyV0KVkF5AzFGb71dF3R5v7v21J7AGfvgQHR1K3LMUtXKjftMAhYItLpq+K
         r1NQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AG47ELtxe28nG2Y6IaMz34eWEEwAZftpG3QRH4i+JleUprl1eBXO8SW6M2L5ZX1b2hq8kciz9kAxLw==
Message-ID: <5a99589f.4a8f1c0a.d3bad.ca96@mx.google.com>
Date: Fri, 02 Mar 2018 05:58:55 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.4.y
X-Kernelci-Kernel: v4.4.119-35-g2fd16f09a713
X-Kernelci-Report-Type: boot
X-Kernelci-Tree: stable-rc
In-Reply-To: <20180302084435.842679610@linuxfoundation.org>
References: <20180302084435.842679610@linuxfoundation.org>
Subject: Re: [PATCH 4.4 00/34] 4.4.120-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593815535923103556?=
X-GMAIL-MSGID: =?utf-8?q?1593834614913011005?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.4.y boot: 78 boots: 0 failed, 76 passed with 2 untried/un=
known (v4.4.119-35-g2fd16f09a713)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.4.y/kernel/v4.4.119-35-g2fd16f09a713/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.4.y=
/kernel/v4.4.119-35-g2fd16f09a713/

Tree: stable-rc
Branch: linux-4.4.y
Git Describe: v4.4.119-35-g2fd16f09a713
Git Commit: 2fd16f09a713e5abaffdc1d8f9ca29a24f542bf9
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 40 unique boards, 16 SoC families, 16 builds out of 177

---
For more info write to <info@kernelci.org>
