Return-Path: <cw00.choi@samsung.com>
X-Google-Smtp-Source: AH8x225sjhV2SGyewhtqj/2hRrrUscOr/2mNjMTzRGbkNXKIPAHVBK+K422BXRX4ub5hApIFQYyU
ARC-Seal: i=1; a=rsa-sha256; t=1519035797; cv=none;
        d=google.com; s=arc-20160816;
        b=MhYoUjxuIZvQMjvpZ0ayqDl5QCdw4h3akXVanmgBOYlfg7OzzxOPLbVEH0leBqtrTt
         bweovc4JAYAyCntZppXlRQNM90hdJhODMrkw59rQ1SP/mKFUhhn6VBt7BcUJDlwAgqF6
         nOloh1QVDUFWAaiwU8z0tc7PC+8uufbjBPgGFhJ4mveyJ5zP6zvpaq4rqCGaluASn7vr
         ztOflh0qhLfEvomtYhGtR8axmNrpFsKLbDg/r9zLnu9GlTjF0cyN0Vwq9OwOrUn1rmmZ
         ndn739LCZ1/0goN/NfaqfyGONNfvAblYyjTsRPf+QiV2hyv1VVJCsAZigRgWfUSnYfeo
         8WMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:content-transfer-encoding:subject:cc
         :to:mime-version:user-agent:organization:from:date:message-id
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=pIGmxO7hT28qvAZIj3WVKJQ9Zly4I9mmmnTHPznC7v0=;
        b=QR74XSxhoJcYWv7D1j/FMy3OEi+vEBXtzh+Xnjxn84KkFUr4jJH3DBnpfcgXWUJ/RX
         2q1vSZ3t/hY1SHdBtVkaH9Y8qzDZuglxeHd7AudNSSLTANY2m2RghsuS4M4WtwSDQvCw
         x/SKteGUcDFxT+t5/dLaY1n30GqsyV3N7258TT593579on392IULQsWeQQWNq+ninUWi
         W9n68wybpaqmJf2uZcsaZX9LPFG6pvwMsO4XrUe6gZzo0PtdbMeru3EOV2Qct5K4Ogmz
         2oYQr8VH96kG75M3M5WrFLOl+07z/MHYRNMrp342KlqrAcJ45l9wbuSAmcFz77IwPfxQ
         Sp1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=jSLIq4RU;
       spf=pass (google.com: domain of cw00.choi@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=cw00.choi@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=jSLIq4RU;
       spf=pass (google.com: domain of cw00.choi@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=cw00.choi@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180219102315epoutp02ff4d58907f41a7cb48937356f1df54ea~UswIAhsOz1355813558epoutp02C
X-AuditID: b6c32a38-adbff70000001054-e9-5a8aa593c430
Message-id: <5A8AA592.40209@samsung.com>
Date: Mon, 19 Feb 2018 19:23:14 +0900
From: Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101
	Thunderbird/31.6.0
MIME-version: 1.0
To: Greg KH <gregkh@linuxfoundation.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	=?UTF-8?B?Iuy1nOywrOyasCAoc2Ftc3VuZy5jb20pIg==?= <cw00.choi@samsung.com>,
	"Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
	=?UTF-8?B?64yA7J246riw?= <inki.dae@samsung.com>, myungjoo.ham@samsung.com
Subject: [GIT PULL] extcon fixes for v4.16-rc3
Content-type: text/plain; charset="utf-8"
Content-transfer-encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmvu7kpV1RBmuecFhMvHGFxeL6l+es
	Fs2L17NZTLo/gcXi8q45bBa3G1ewObB5bFrVyeaxf+4ado++LasYPT5vkgtgiUq1yUhNTEkt
	UkjNS85PycxLt1XyDo53jjc1MzDUNbS0MFdSyEvMTbVVcvEJ0HXLzAFarqRQlphTChQKSCwu
	VtK3synKLy1JVcjILy6xVYo2NDTSMzQw1zMyMtIzMY61MjIFKklIzeg5K1twlK/i1Z0HbA2M
	k3m6GDk5JARMJF78vsjSxcjFISSwg1Fi78JdrBDOd0aJD9O7WWCqDjeeYYRI7GaU2Lz+KZRz
	j1Hib88NVpAqXgENiWMrJ4PZLAKqEjcn7mIHsdkEtCT2v7jBBmLzCyhKXP3xmBHEFhWIkNg5
	/xs7RK+gxI/J98C2iQDNeXn0FthNzALTmCRW/msDKxIW0JNYtPI2M4jNLKAp8eLLJBYIW15i
	85q3zCANEgIr2CQON99jhbjbRWLmhheMELawxKvjW4AGcQDZ0hKXjtpC1LczSrTvnQfVPIVR
	4tz1e0wQDcYSzxZ2MUFs4JN497WHFaKZV6KjTQiixEPi09+VUOWOEutfPAHbJSQQK7F9QQPL
	BEbZWUiem4Xk7llI7l7AyLyKUSy1oDg3PbXYsMBErzgxt7g0L10vOT93EyM4kWlZ7GDcc87n
	EKMAB6MSD6/Axs4oIdbEsuLK3EOMEhzMSiK8FiFdUUK8KYmVValF+fFFpTmpxYcYTYERMZFZ
	SjQ5H5hk80riDU0sDUzMjICJytLQUEmcNyDAJUpIID2xJDU7NbUgtQimj4mDU6qBsV78yJSX
	2XmZUW9uX1iepZn4x7p17qTNp0IsVz3cqsRqntulukdQV6+nbQHPj9gn2qfspfWWpK9bEOqy
	/7mjm7V9Ztp1jn8/RL2+OMw0i9XrMpTuCfue+0o9d9uDNKGaxLfx260friy0W/R5e/GTG9eN
	pv1IiXla1KuzvzL61p/oG0Wu3U/6lViKMxINtZiLihMB3WRYkHoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFLMWRmVeSWpSXmKPExsVy+t9jAd1JS7uiDB585LeYeOMKi8X1L89Z
	LZoXr2ezmHR/AovF5V1z2CxuN65gc2Dz2LSqk81j/9w17B59W1YxenzeJBfAEsVlk5Kak1mW
	WqRvl8CV0XNWtuAoX8WrOw/YGhgn83QxcnJICJhIHG48w9jFyMUhJLCTUeLZkTOsIAkhgQeM
	EucPc4PYvAIaEsdWTgaLswioStycuIsdxGYT0JLY/+IGG4jNL6AocfXHY6BBHByiAhES3Scq
	IVoFJX5MvscCYosAjXl59BYLyC5mgWlMEjuPnQHrFRbQk1i08jYzSC+zgLrElCm5IGFmAXmJ
	zWveMk9g5JuFZNQshKpZSKoWMDKvYpRMLSjOTc8tNiowzEst1ytOzC0uzUvXS87P3cQIDNFt
	h7X6djDeXxJ/iFGAg1GJh1dgY2eUEGtiWXFl7iFGCQ5mJRFei5CuKCHelMTKqtSi/Pii0pzU
	4kOM0hwsSuK8t/OORQoJpCeWpGanphakFsFkmTg4pRoYNwUHP7m8qNOZV/3iL8uoT8xyqvYO
	+R/X+Ju95l1U2iW9bZ3w9x9b6iptOq03zfjUvGXzz5V+Tjunyb3x+xtmVXNurqBj44K61UY2
	Zg3K7Jud+A5wbtWyu3p9SXDRpD3/566PiZ4iKinqE8psHBj4+Xrpp1Jeh30abzz/qOuZix++
	+yUndI6/EktxRqKhFnNRcSIAkKS8pE0CAAA=
X-CMS-MailID: 20180219102314epcas1p19ec4367b2623c25334fb1530393ec8fb
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180219102314epcas1p19ec4367b2623c25334fb1530393ec8fb
X-RootMTR: 20180219102314epcas1p19ec4367b2623c25334fb1530393ec8fb
References: <CGME20180219102314epcas1p19ec4367b2623c25334fb1530393ec8fb@epcas1p1.samsung.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592824480666817122?=
X-GMAIL-MSGID: =?utf-8?q?1592824480666817122?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Dear Greg,

This is extcon-fixes pull request for v4.16-rc3. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi

The following changes since commit 7928b2cbe55b2a410a0f5c1f154610059c57b1b2:

  Linux 4.16-rc1 (2018-02-11 15:04:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-fixes-for-4.16-rc3

for you to fetch changes up to 0434352d3d2e950cf5e743f6062abd87de22f960:

  extcon: int3496: process id-pin first so that we start with the right status (2018-02-14 06:37:33 +0900)

----------------------------------------------------------------
Update extcon for v4.16-rc3

This patch fixes issue of X-power extcon-axp288 and Intel extcon-int3496 driver.
- For extcon-int3496 driver,
Process id-pin first so that we start with the right status in order to fix
a race where the initial work might still be running while other drivers
were already calling extcon_get_state().

- For extcon-axp288 driver,
Revert the patch[1] which were applied to v4.16-rc1 because there are better
ways with usb-role-switch and constify the axp288_pwr_up_down_info array.
[1] 60ed99961469a3 ("extcon: axp288: Redo charger type detection a couple of seconds after probe()")

----------------------------------------------------------------
Hans de Goede (3):
      extcon: axp288: Constify the axp288_pwr_up_down_info array
      Revert "extcon: axp288: Redo charger type detection a couple of seconds after probe()"
      extcon: int3496: process id-pin first so that we start with the right status

 drivers/extcon/extcon-axp288.c        | 36 ++++-------------------------------
 drivers/extcon/extcon-intel-int3496.c |  3 ++-
 2 files changed, 6 insertions(+), 33 deletions(-)
