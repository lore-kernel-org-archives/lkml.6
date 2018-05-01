Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525136659; cv=none;
        d=google.com; s=arc-20160816;
        b=njUfMH/qaLLgwq8sV1eBCX9ZhUIvwO5v/rv37vjanWwZz7r/ryYIxs5+lZZWVwh09C
         ICfpDNsAThvCRG5DM4XtpP+wPYxYBAuzgHRSvsSx/FloYV75dVKGg0t/MRBdr2uyoDom
         cd6flv1+kd140Xn49gMiUauIc4NqOAs76lAZTRN3amRAzaMZHMmZdn1IY7Ljglkdkdq+
         AzKbG8roPAxf4VWUF2szpK/6fPoefLWmKceNq3HPszvLyHAjtA9lg5369bSXdR2qKvQN
         JytNPyEw9zND0VzizILP6Nb1PF3rs7bbR7PXjsh3jSVb/QnH2FFurNFbPhQUW+WSQYuC
         jo3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=0ameSpFel26aT2ChuY8VdIIHwtbvxw59t/5/mHOZBoI=;
        b=eu0fQsX6Nkfl1sPyxPdE6PjllebAP3kDaHCjXXzywxJXx0v2SZTPv2kxP0vZ6A6Vw4
         Qht+yo51Hcbo5VOm+sjSCQYG5FMAJQIxnF1N9OxzeeFNHITuPAcJafWpjPhcRcDlKxIR
         fTyB4m6Jv0PK4woiKpYvb7wRFS9D343GXDFV4MEK5Id/SM/d4foFhcPDQNYg2hbbHXH4
         t1uJMwe5hyR4dCaMYySjaab8fmroZokaiq/M1uaqkOMVsRrIMfTic3PLKKSJKmKRuDoy
         WKLpW3/oUc49CrCdIHx7l5Jx99QeJigXl11lNidY6Iixi7mgn1Lo8TviE1M2FaILKLfm
         ZWjw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AB8JxZohUvjYBBQ9iBTX1X3a8IQDQNpsAfkfapPCSRD0jENDAv3Uxn/LZzAcxLesn3sToRKN3C1wUg==
Message-ID: <5ae7bd11.1c69fb81.95955.6be6@mx.google.com>
Date: Mon, 30 Apr 2018 18:04:17 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-3.18.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v3.18.107-26-g261b9a2d80e9
In-Reply-To: <20180430183910.801976983@linuxfoundation.org>
References: <20180430183910.801976983@linuxfoundation.org>
Subject: Re: [PATCH 3.18 00/25] 3.18.108-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599200268789190038?=
X-GMAIL-MSGID: =?utf-8?q?1599221697683480844?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-3.18.y boot: 62 boots: 0 failed, 62 passed (v3.18.107-26-g2=
61b9a2d80e9)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-3.18.y/kernel/v3.18.107-26-g261b9a2d80e9/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-3.18.=
y/kernel/v3.18.107-26-g261b9a2d80e9/

Tree: stable-rc
Branch: linux-3.18.y
Git Describe: v3.18.107-26-g261b9a2d80e9
Git Commit: 261b9a2d80e901dfcaaf4feeaa2b900685f53a96
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 31 unique boards, 12 SoC families, 15 builds out of 183

---
For more info write to <info@kernelci.org>
