Return-Path: <bot@kernelci.org>
ARC-Seal: i=1; a=rsa-sha256; t=1523426546; cv=none;
        d=google.com; s=arc-20160816;
        b=OAXGJG8Q9UYGAgV454E6FKv/iiPEDkBGfhe794ZKbfsJoElBWNDAn8Z8k0fwH+zHa8
         67NIe65RFdd+fvpbXywwQyD00ua1vdv5UoBG7mlBsNukonVK8XwyirEEv1Q3FmvblMtX
         keaKDsUJJ1qlLzCCeX9DmaYaj/EAMs9rPjMfPa1ukHRXS8U5BjKm6NpGGtYKrW7kowxS
         SXUtKvP4jRLK/PtNqwp2ik2MJAhNt8qvvNf1nsmnY2deSCJJ2xTLdyaTXsBkZemYujK5
         IwPX4TXcN7Zwrv6rtV9yaK8WCKNcVotgPDJtMpu7Zktu2Lkj/zwa0cUz0KW+DC0tkrqF
         S7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:from:to:subject:references:in-reply-to:content-transfer-encoding
         :mime-version:date:message-id:arc-authentication-results;
        bh=qpTJU6xJsJbAdtX2Y/0nwDPUR7yXYpSUdTjyeYss1sM=;
        b=TwuYksPdYHsq8wQs8DclDl3twZqE5RTYch6VAHpXjxq+ZWPPyHvgKW8RqXVhjlO0wZ
         6QRw5Vyl44tUdfPwczv9rGO/X5VvxkPACWd82dU3kRcLMe9zqiJpDZcr5a8aWsaWp5pV
         1DRzPvr7ZowwLoHo34vrSV0j5bhN9BWACTNH6TVSrVRlucYbNHtFjbO6exfMjFr8Zzi+
         z0wq1jSeRxHxcJ81rbZZi0/woEeeuQpRTh0gqWQY9F9UA844+ZkhVy2iP8KnaI6bITVM
         av8cyEf6rIA01CypHMQvJ4YaBsmqIfMXy8HY8vc/EuxB++0sdtSeu8rMz/1QB5UO73P1
         QeGQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of bot@kernelci.org designates 209.85.220.41 as permitted sender) smtp.mailfrom=bot@kernelci.org
X-Google-Smtp-Source: AIpwx4/ZZ3CLmnK0HY9uzlAj0/51oDrsByZ2fcQNmIUYxZNjdN56RBKHOKEZtVrYXJY9xnfq/Dug1w==
Message-ID: <5acda4f1.4d2f1c0a.7055a.3560@mx.google.com>
Date: Tue, 10 Apr 2018 23:02:25 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Kernelci-Branch: linux-4.16.y
X-Kernelci-Tree: stable-rc
X-Kernelci-Report-Type: boot
X-Kernelci-Kernel: v4.16.1-19-g132318e83781
In-Reply-To: <20180410212758.564682823@linuxfoundation.org>
References: <20180410212758.564682823@linuxfoundation.org>
Subject: Re: [PATCH 4.16 00/18] 4.16.2-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
From: kernelci.org bot <bot@kernelci.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net,
 shuahkh@osg.samsung.com, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597399674077980265?=
X-GMAIL-MSGID: =?utf-8?q?1597428515073747816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

stable-rc/linux-4.16.y boot: 82 boots: 1 failed, 79 passed with 2 untried/u=
nknown (v4.16.1-19-g132318e83781)

Full Boot Summary: https://kernelci.org/boot/all/job/stable-rc/branch/linux=
-4.16.y/kernel/v4.16.1-19-g132318e83781/
Full Build Summary: https://kernelci.org/build/stable-rc/branch/linux-4.16.=
y/kernel/v4.16.1-19-g132318e83781/

Tree: stable-rc
Branch: linux-4.16.y
Git Describe: v4.16.1-19-g132318e83781
Git Commit: 132318e8378141c48aab973d050dc5c780da65db
Git URL: http://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git
Tested: 40 unique boards, 15 SoC families, 15 builds out of 186

Boot Regressions Detected:

arm:

    multi_v7_defconfig:
        sun5i-gr8-chip-pro:
            lab-free-electrons: new failure (last pass: v4.16.1)

Boot Failure Detected:

arm:

    multi_v7_defconfig
        sun5i-gr8-chip-pro: 1 failed lab

---
For more info write to <info@kernelci.org>
