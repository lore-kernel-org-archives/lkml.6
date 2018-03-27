Return-Path: <sw0312.kim@samsung.com>
X-Google-Smtp-Source: AG47ELt6K5Hk3eIxg+yZGfGFvsye4O0mJig4/4uRnCVg2mcnIdJtCK01Lofnc9g1AGK0XPgp4Z9T
ARC-Seal: i=1; a=rsa-sha256; t=1522114828; cv=none;
        d=google.com; s=arc-20160816;
        b=XhCKcU6DfOG0DKWbbuvxPRwO/3aR85VchcMOqs7TKUBvbVwmg4lINuVCnomB6vzvBN
         i2i5kr22umvfAeunHiKmWjvbO+CKunmFncxwlNzemRFvdmZhwRhHhJexWOetPwHWY7BI
         6Ii/SzSlqqBEACs2J9UNacJJk9lXwfHMoo20BCApGbXUqzeAjsCSBMvY1UOTZ8Fhx+/B
         j6y3TFiLmj3q5z827cOOG6xJ7teuX4O5ccjRoc4oUNwVFaBwlx/Kzt/jydtW1La8AQqp
         1wxlqQ8O4Y2j/bdYYFPUl3tObq0s0mgYbcPywmDuHY7Y73c8BQMFJKiCblKXTMkQRkj7
         ULFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:in-reply-to:subject:cc:to:user-agent
         :reply-to:from:date:message-id:content-transfer-encoding
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=+7Z+H32PgSgo3qR0pKLD4NptZ+x6MqrkESeCjdjPDJg=;
        b=a9uebAUDFRgalsg0YeF4Aibl+NquAsBo+gg8Pm+PY9QKGkvZATfwFzNWuIy/wY3vkR
         yzv67Tg7sJc6F1ZZYF71kASo9/kSIg3kWF7RZQ6WnljHtgyAKx8pfFT4SC4sAwuM5MZF
         b2aJLczfMygcwz1/vu2KDqgcUNltgWOXk7Xmo4n1mOeRvQkG+a39y+DWYRMKZPF+PdI3
         5FVj0X2ZRVfqad5duoMZdenGxAnfxplo9y215QCkDqnPR00xL+Ltw7kG8WxqrhAH2fGf
         5SxpKXTAFk+IweitaxqrwdmhQ2M1tspNYzI6oBLh+VNbwX88M+1hiWPfVlB94rryWUnv
         AW5g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=HjNnY1Vm;
       spf=pass (google.com: domain of sw0312.kim@samsung.com designates 203.254.224.33 as permitted sender) smtp.mailfrom=sw0312.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=HjNnY1Vm;
       spf=pass (google.com: domain of sw0312.kim@samsung.com designates 203.254.224.33 as permitted sender) smtp.mailfrom=sw0312.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180327014027epoutp03e751499c3966ecd2f923a85c8519c579~fo17xRPqG0811408114epoutp03R
X-AuditID: b6c32a46-b85ff70000000fe8-1d-5ab9a10a74c7
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AB9A111.1080105@samsung.com>
Date: Tue, 27 Mar 2018 10:40:33 +0900
From: Seung-Woo Kim <sw0312.kim@samsung.com>
Reply-to: sw0312.kim@samsung.com
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011
	Thunderbird/16.0.1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mchehab@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 3.18.102
In-reply-to: <20180325085952.GA31575@kroah.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOKsWRmVeSWpSXmKPExsWy7bCmhS7Xwp1RBr+vq1k0L17PZnF51xw2
	i2Wb/jBZzJj8ks2BxWPTqk42j/1z17B79G1ZxejxeZNcAEtUqk1GamJKapFCal5yfkpmXrqt
	kndwvHO8qZmBoa6hpYW5kkJeYm6qrZKLT4CuW2YO0EolhbLEnFKgUEBicbGSvp1NUX5pSapC
	Rn5xia1StKGhkZ6hgbmekZGRnolxrJWRKVBJQmrGh8fzGQtucFc0HJvL3MD4hbOLkYNDQsBE
	Ytlhky5GLg4hgR2MEke+PmWGcL4zSrTvfcHWxcgJVvRr8mlWiMRuRon+OZ0sIAleAUGJH5Pv
	sYBMYhaQlzhyKRskzCygKbF193p2iPp7jBItB7eyQdRrSUy5sZgdxGYRUJW4ee43E4jNJqAj
	sX/Jb1YQW0hAQeLKxGNgNaICYRIzDvYzgtgiAhoSL4/eYoFYYCLR9WkeWK+wgLTE9U2XwWxO
	AX2J1qMT2EAWSwhsYJPYc6mdCeIDF4nnu15A2cISr45vYYewpSWerdrICGG3M0osuxYA0TyF
	UWLX1U1QDcYSzxZ2MUFs5pPoOPyXHRJ2vBIdbUIQJR4Slz7uhyp3lGiYthEajE2MEgfuXWWe
	wCg3CynAZiECbBZSgC1gZF7FKJZaUJybnlpsVGCkV5yYW1yal66XnJ+7iRGcyLTcdjAuOedz
	iFGAg1GJh3cGx84oIdbEsuLK3EOMEhzMSiK8fPN3RAnxpiRWVqUW5ccXleakFh9iNAWG90Rm
	KdHkfGCSzSuJNzSxNDAxMzMyN7MAJjBx3tYAlyghgfTEktTs1NSC1CKYPiYOTqkGRp7TcYsv
	vZIJmMhpffSm1p2sXNE53+daqF67f2Hl9IIonco/Kveqmj9sOSvz3zs673Of4dfQux8nL1x5
	O1El9d5LtaK5bhMdXeZY6dV2zLj04XNTcUnUmzub/vtwz/eRY+aIXeQ4M/LXP+2KfquKJoGW
	tK1hgqUW5ccqT936KBWfnfhJdPaER0osxRmJhlrMRcWJADNvjEJ6AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t9jAV2uhTujDP6tE7NoXryezeLyrjls
	Fss2/WGymDH5JZsDi8emVZ1sHvvnrmH36NuyitHj8ya5AJYoLpuU1JzMstQifbsErowPj+cz
	Ftzgrmg4Npe5gfELZxcjJ4eEgInEr8mnWUFsIYGdjBL3z4uD2LwCghI/Jt9j6WLk4GAWkJc4
	cikbJMwsoC4xad4i5i5GLqDyB4wSrWtOMUHUa0lMubGYHcRmEVCVuHnuN1icTUBHYv+S31Dz
	FSSuTDzGDjJTVCBMYufmdJCwiICGxMujt1gg5ptIdH2aB9YqLCAtcX3TZSaIXS2MEpsubmAG
	SXAK6Eu0Hp3ANoFRYBaSU2chnDoLyakLGJlXMUqmFhTnpucWGxUY5aWW6xUn5haX5qXrJefn
	bmIEBvC2w1r9OxgfL4k/xCjAwajEwzuDY2eUEGtiWXFl7iFGCQ5mJRFevvk7ooR4UxIrq1KL
	8uOLSnNSiw8xSnOwKInz8ucfixQSSE8sSc1OTS1ILYLJMnFwSjUwMrS2rExjcd18sFgpPkf/
	vWn0ih7vma1CBdIT/ZQbbxy7+mmBs4T/otVLc44+4eObIHSAu6Hy1YZll7vPvgkNvXT3YZ/n
	lgSfxvzDJrVG+772M4mxiejftole9fjQ8wuKlcuKFWpfKa8zcu1ylCr8mL5pivz1nKD/ItuS
	UwMdFUWl5xu2XNBSYinOSDTUYi4qTgQAW14eTVwCAAA=
X-CMS-MailID: 20180327014026epcas2p4e9ab141c4f9d32bc9eed123d26e6b0b4
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180325090010epcas1p2864bb6fe3cbc420bc71eb0e7f1c847f1
X-RootMTR: 20180325090010epcas1p2864bb6fe3cbc420bc71eb0e7f1c847f1
References: <CGME20180325090010epcas1p2864bb6fe3cbc420bc71eb0e7f1c847f1@epcas1p2.samsung.com>
	<20180325085952.GA31575@kroah.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595911656234901027?=
X-GMAIL-MSGID: =?utf-8?q?1596053078949571846?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

Until 3.18.102, it looks like following patch series for v4l2 seems missed.

273caa2 media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs
a1dfb4c media: v4l2-compat-ioctl32.c: refactor compat ioctl32 logic
d83a824 media: v4l2-compat-ioctl32.c: don't copy back the result for
certain errors
169f24c media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type
a751be5 media: v4l2-compat-ioctl32.c: copy clip list in put_v4l2_window32
b8c601e media: v4l2-compat-ioctl32.c: fix ctrl_is_pointer
8ed5a59 media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32
333b1e9 media: v4l2-compat-ioctl32.c: avoid sizeof(type)
486c521 media: v4l2-compat-ioctl32.c: move 'helper' functions to
__get/put_v4l2_format32
b7b957d media: v4l2-compat-ioctl32.c: fix the indentation
3ee6d04 media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF
181a4a2 media: v4l2-ioctl.c: don't copy back the result for -ENOTTY

Any plan to apply the series?

Best Regards,
- Seung-Woo Kim

On 2018년 03월 25일 17:59, Greg KH wrote:
> I'm announcing the release of the 3.18.102 kernel.
> 
> All users of the 3.18 kernel series must upgrade.
> 
> The updated 3.18.y git tree can be found at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-3.18.y
> and can be browsed at the normal kernel.org git web browser:
> 	http://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary
> 
> thanks,
> 
> greg k-h
> 
