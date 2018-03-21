Return-Path: <cw00.choi@samsung.com>
X-Google-Smtp-Source: AG47ELtKpIABuL+msC18Cd0QUzRLRENNDaRLbc700WyGwiYMUiCpOq8YAi88Vwllwj3U9/g36bMi
ARC-Seal: i=1; a=rsa-sha256; t=1521609184; cv=none;
        d=google.com; s=arc-20160816;
        b=DagWfwNTMzzzexV5rLpfVP1dDlFEZq/FMSfumFmsWfY4SfQgpDjOLKBPvQwKzqGbaB
         O2hlNyxMKiNbNENcicGVcZMl8srEooRSXjiRhRTjyMWg95A3cRbpF2NbW4nc9b7K/JyZ
         tUpWavZ8yxxfg+qKVW+7FQ6LIur7hlv3pmdhjt64zwEMeEzE6DU43HEURxTUpQqxLHEa
         QTLaQs1aiHi5nVMTmnT09M2neJtmJd5sAqCo6hX+QP42abbMR9WGRem/36FprMYgIeh4
         gb48uRSbSOxhI4N6RmKtu6bZmXy9M6dGzUd7jxpmRW7EMrjNKxCZhtcKrUDyst5cZq0R
         g+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:content-transfer-encoding:subject:cc
         :to:mime-version:user-agent:organization:from:date:message-id
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=HdIamLuLPSbBEnCfSej7vg7B46J7bqI9LIvV177SJuY=;
        b=AA1uxs/WWqIVPLlcPdHlkMt0+X99AP68DG7RV0RsrI98hZICEDJKpgdd+DMSz1upI9
         EPC3E2gNCQs5GURaVL8TmYr5yMh7VBgBfQqibfRq/cPDb0kVH5IKD1iHMmX1zyGqfxAt
         eRCGhNHyHz8xmZOMarFkPqN02JxhcypS9pEUv9twTDSm2545MsggrP1Rz3OY3fRoPGOG
         +2RCDkkEg6CqGuR8ZhePMAslDQR3HB6m44tdsjtOf/DUi+32FgvyIUZaowg633N64+0V
         Zbh+rwMUJBzFq9eygPXoEARrqRqfBqRtZJ7F7j7UitIbuFbXFRgVP7cs3zaMiZdtr26i
         HmNw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=e+Ww0e4e;
       spf=pass (google.com: domain of cw00.choi@samsung.com designates 203.254.224.34 as permitted sender) smtp.mailfrom=cw00.choi@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=e+Ww0e4e;
       spf=pass (google.com: domain of cw00.choi@samsung.com designates 203.254.224.34 as permitted sender) smtp.mailfrom=cw00.choi@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20180321051302epoutp0409b7ce9237c6a5785f5ca8b95937c709~d131Evnh00991109911epoutp042
X-AuditID: b6c32a45-3ebff70000001023-e4-5ab1e9dd29d6
Message-id: <5AB1E9DD.50409@samsung.com>
Date: Wed, 21 Mar 2018 14:13:01 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
	Thunderbird/31.6.0
MIME-version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?UTF-8?B?Iuy1nOywrOyasCAoc2Ftc3VuZy5jb20pIg==?= <cw00.choi@samsung.com>,
	=?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, =?UTF-8?B?7ZWo66qF7KO8?=
	<myungjoo.ham@samsung.com>
Subject: [GIT PULL] extcon next for v4.17
Content-type: text/plain; charset="utf-8"
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7bCmqe7dlxujDO6e0bS4/uU5q0Xz4vVs
	FpPuT2CxuLxrDpvF7cYVbA6sHvvnrmH36NuyitHj8ya5AOaoVJuM1MSU1CKF1Lzk/JTMvHRb
	Je/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoJVKCmWJOaVAoYDE4mIlfTubovzSklSF
	jPziElulaENDIz1DA3M9IyMjPRPjWCsjU6CShNSMHY/3sRe8lK5YdmkjYwNjp1gXIyeHhICJ
	xPrDr5hAbCGBHYwSW29LQdjfGSVuftGBqTly9CILRHw3o8SKE2pdjFxA9l1GiYMtjWwgCV4B
	DYkzF3aBFbEIqEpM6vwDZrMJaEnsf3EDrIZfQFHi6o/HjCC2qECExM7539ghegUlfky+B1Yv
	AjTn5dFbYDYzyBEXfgeD2MICmhIbTk9lgohrSrz4MgmqRl5i85q3zCAHSQjMYJPYd3AXM8TV
	LhJbH0yHsoUlXh3fwg5hS0s8W7WREaKhnVGife88qO4pjBLnrt9jgqgylni2sAtqHZ9Ex+G/
	QN0cQHFeiY42IYgSD4n+o1OghjpKXP20hBUSRLES9xcfYZrAKDsLyXOzkBw+C8nhCxiZVzGK
	pRYU56anFhsVGOoVJ+YWl+al6yXn525iBCcsLdcdjDPO+RxiFOBgVOLhtRDbGCXEmlhWXJl7
	iFGCg1lJhPfhE6AQb0piZVVqUX58UWlOavEhRlNgRExklhJNzgcm07ySeEMTSwMTMzMjczML
	YKIS520LcIkSEkhPLEnNTk0tSC2C6WPi4JRqYPS+2Fe1q4Lh4yOBP6eS51m9XxXsG9thnX7i
	bCdrOJe/66RHslVqSi+Z/RetuJVv1nH71pwS+fhLEi5ad8uSHi18bm25JnRhb8Qet/P+u9bz
	nurbNsuW91cvX6MDU9WCvxtC668fEuhve/vSYPeafIsnWQmP74o8PF3O8U5EsDw/d/5mn55t
	85VYijMSDbWYi4oTAb53RTluAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsVy+t9jAd27LzdGGRzrk7C4/uU5q0Xz4vVs
	FpPuT2CxuLxrDpvF7cYVbA6sHvvnrmH36NuyitHj8ya5AOYoLpuU1JzMstQifbsErowdj/ex
	F7yUrlh2aSNjA2OnWBcjJ4eEgInEkaMXWboYuTiEBHYySry5MAHKuc8o8bx7JStIFa+AhsSZ
	C7tYQGwWAVWJSZ1/wGw2AS2J/S9usIHY/AKKEld/PGbsYuTgEBWIkOg+UQnRKijxY/I9sHIR
	oDEvj94Cm88s8J1RoufCIUaQhLCApsSG01OZQHqZBdQlpkzJBQkzC8hLbF7zlnkCI98sJKNm
	IVTNQlK1gJF5FaNkakFxbnpusVGBUV5quV5xYm5xaV66XnJ+7iZGYEhuO6zVv4Px8ZL4Q4wC
	HIxKPLwWYhujhFgTy4orcw8xSnAwK4nwPnwCFOJNSaysSi3Kjy8qzUktPsQozcGiJM7Ln38s
	UkggPbEkNTs1tSC1CCbLxMEp1cA4qTvu8t1lyl1HCt6Lfz2qW/F8eRT3/CvGqiLtHO+SKtdO
	irz2SlhgnXIRz1TuVSmdM8yv270y1De9bhvXK93TPXey2grHfQZrZtx9Gi5acSNN7z1vxhfW
	R8GsNfcP7bqlk5CZdyVmQcK6MJ3ZtaX6GTJJXFJnZz1jsapy73h0dp2fxsxpL68rsRRnJBpq
	MRcVJwIAkgsUJkUCAAA=
X-CMS-MailID: 20180321051301epcas2p2cfbf21e88849e15d17b6cdb8be0baf8f
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180321051301epcas2p2cfbf21e88849e15d17b6cdb8be0baf8f
X-RootMTR: 20180321051301epcas2p2cfbf21e88849e15d17b6cdb8be0baf8f
References: <CGME20180321051301epcas2p2cfbf21e88849e15d17b6cdb8be0baf8f@epcas2p2.samsung.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595522872988527631?=
X-GMAIL-MSGID: =?utf-8?q?1595522872988527631?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dear Greg,

This is extcon-next pull request for v4.17. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 4a3928c6f8a53fa1aed28ccba227742486e8ddcb:

  Linux 4.16-rc3 (2018-02-25 18:50:41 -0800)

are available in the git repository at:

git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-4.17

for you to fetch changes up to eb7768e774d12eac1189984a62925bc3bb386e13:

  Merge branch 'ib-extcon-drm-dt-v4.17' into extcon-next (2018-03-21 13:58:23 +0900)

----------------------------------------------------------------

Update extcon for 4.17

Detailed description for this pull request:
1. Add exported extcon function in order to support OF graph binding
- The extcon consumer driver used the "extcon = <&extcon's phandle"
  property in device-tree in order to bind between extcon provider
  and consumer driver. But, OF graph method is better than 'extcon' property.
  So, extcon subsystem adds the following function to support OF graph binding.
  : extcon_find_edev_by_node(struct device_node *node)

- Create the immutable branch ("ib-extcon-drm-dt-v4.17") for both drm-misc
  and device-tree subsystem. This immutable branch contains the use-case of
  OF graph binding for EXTCON_HDMI connector between MHL device driver
  and extcon provider driver.

2. Fix minor issues of extcon device drivers
- Remove platform_data and covert to fully use GPIO descriptor for extcon-gpio.c
- Remove workaround code for id pin direction from extcon-inte-int3496.c
  because GPIO ACPI library does support it with generic way.
- Set direction and drv flags for V5 boost GPIO because of fixing
  the firmware bug.

----------------------------------------------------------------
Andrzej Hajda (3):
      dt-bindings: add bindings for USB physical connector
      dt-bindings: add bindings for Samsung micro-USB 11-pin connector
      extcon: add possibility to get extcon device by OF node

Andy Shevchenko (1):
      extcon: int3496: Ignore incorrect IoRestriction for ID pin

Chanwoo Choi (1):
      Merge branch 'ib-extcon-drm-dt-v4.17' into extcon-next

Hans de Goede (1):
      extcon: intel-cht-wc: Set direction and drv flags for V5 boost GPIO

Linus Walleij (3):
      extcon: gpio: Localize platform data
      extcon: gpio: Move platform data into state container
      extcon: gpio: Convert to fully use GPIO descriptor

Maciej Purski (1):
      drm/bridge/sii8620: use micro-USB cable detection logic to detect MHL

 .../connector/samsung,usb-connector-11pin.txt      |  49 ++++++++++
 .../bindings/connector/usb-connector.txt           |  75 +++++++++++++++
 drivers/extcon/extcon-gpio.c                       | 103 +++++++++------------
 drivers/extcon/extcon-intel-cht-wc.c               |  11 ++-
 drivers/extcon/extcon-intel-int3496.c              |   9 +-
 drivers/extcon/extcon.c                            |  44 +++++++--
 drivers/gpu/drm/bridge/sil-sii8620.c               |  97 ++++++++++++++++++-
 include/linux/extcon.h                             |   6 ++
 include/linux/extcon/extcon-gpio.h                 |  47 ----------
 9 files changed, 315 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/connector/samsung,usb-connector-11pin.txt
 create mode 100644 Documentation/devicetree/bindings/connector/usb-connector.txt
 delete mode 100644 include/linux/extcon/extcon-gpio.h
