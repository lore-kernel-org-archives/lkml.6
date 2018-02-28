Return-Path: <b.zolnierkie@samsung.com>
X-Google-Smtp-Source: AH8x225CMgeosxITMfno+32E0bvGrGsmVE5BHxMH32LipsbBAyL8Bl7QcW2neJAWYPkApULvmD4a
ARC-Seal: i=1; a=rsa-sha256; t=1519830884; cv=none;
        d=google.com; s=arc-20160816;
        b=gVkFJMwvLPPVtP402f2FGtIFi+NgW4g7ZAC0+9HBSMYnMPIUxHl75zrdpPyCFxxqPA
         Fn6t/yOYTZSno2AkPt4brZfd7vlbBC5vpqqh4+4XXh2YEXni37/vWrnanZ6WQxCnHwho
         9OE09kh3Urfj2KDZFTeVk7OLo28hSYVi7la7m8rat6aMFqLggG4LvhAuqysuGDuyetuW
         mrvHug8Ln7dOon/8jXBP1Md9x/tI7aKbAV658NoH4/x66oqHdjIELP6HBUWjHZiozdSw
         7/lmFapwgqJE7h1UcUaKEBf/98oWURQdIESNWApKhx+WfoiuOL1ldFi5mLnTGapBoOZx
         HPSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:cms-type:content-transfer-encoding:mime-version
         :in-reply-to:user-agent:message-id:date:subject:cc:to:from
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=wczyl3sY6GVE5FDG8aBaMYI7io3kvZtL1xKLIkhhPDY=;
        b=rJtLR65qeB6RBNj8pmyAAjz//mUrtdclICeXj7FuuTJ3N5o+O1Yz7e5fHyuIVyGiGe
         FbqBLSQCGoKmpGEkQGZojEyZoeYOxYQrG1tjtW4s6MfAtc/g4msS4tj0hi/mFYL05ehp
         1SkWQh5MQM1tC5W0nLTRroiMT6D23+/VBk+a2/SgtlFRl6o74+SovtXQCVjWFiNI6fzI
         VuwPbiqMLBJGMHFSOzeyCwD1bz6WhaiQWfLJ5JG+jRQqMeSxy1eEHHVj3ccElmDi+2EM
         Ub3O2WNUi7V1jVB91H96C1TEoe2ynHKioOsR5nEWssMqLv2Pra3KHSiniE2Txjt6xMt9
         X/iw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=VSCdmyP3;
       spf=pass (google.com: domain of b.zolnierkie@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=b.zolnierkie@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=VSCdmyP3;
       spf=pass (google.com: domain of b.zolnierkie@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=b.zolnierkie@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180228151442epoutp02a96eb1163cb4ad5db782dc48558b42f1~XhiKZZ59g0323903239epoutp02-
X-AuditID: b6c32a45-403ff70000001023-14-5a96c761b946
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sami Tolvanen
	<samitolvanen@google.com>, Nicolas Pitre <nicolas.pitre@linaro.org>, Thomas
	Winischhofer <thomas@winischhofer.net>, linux-usb@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] console: Expand dummy functions for CFI
Date: Wed, 28 Feb 2018 16:14:38 +0100
Message-id: <2698133.VOZeH6rfJt@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1712993.EvPlpO244k@amdc3058>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZdljTVDfx+LQog113VS2ufH3PZtG8eD2b
	xZnuXIsTfR9YLS7vmsNmsWhZK7PFp2f/2C2WrnjLarF65WN2B06P2Q0XWTwWbCr1uHNtD5vH
	/rlr2D3udx9n8vi8Sc5jwYz/LAHsUVw2Kak5mWWpRfp2CVwZfROOsBQ8Z6m48fAAawPjJ+Yu
	Rk4OCQETibnHJ7N3MXJxCAnsYJTY27WIFSQhJPCdUaJ3QSRM0fonr9kginYzStxrnMoEUfSV
	UWLKPH0Qm03ASmJi+ypGEFtEQFXi+6VmZpAGZoEtTBKnet6CJYQFHCTu7p7FDmKzABXtv38U
	bBCvgKbE/L2b2EBsUQEviS372sHinAJaEh++L2aDqBGU+DH5HguIzSwgL7Fv/1RWCFtH4uyx
	dYwgyyQEbrNJ3F50Aeo3F4mdTVNYIGxhiVfHt7BD2NISz1ZthGpYxSjx8+pfKGczo8Tn619Z
	IaqsJQ4fvwi1gk+i4/BfoG4OoDivREebEESJh8SjDojrJAQcJRoPbWODB+Tq2dPYJzDKzkJy
	+Swkl89CcvkCRuZVjGKpBcW56anFRgWGesWJucWleel6yfm5mxjByUTLdQfjjHM+hxgFOBiV
	eHgd9k+LEmJNLCuuzD3EKMHBrCTCe3o7UIg3JbGyKrUoP76oNCe1+BCjNAeLkjhvW4BLlJBA
	emJJanZqakFqEUyWiYNTqoGR7UoWyyfntyY7Wie2Mr/dsOp1cMzu3xH8nz/cln59+rXsXve2
	n5sca9uVFK20IvqVU2b333lW9Nhx+7umvxPnX3xws3JCew/L3Adt/SqrD+xpl7nExfKAI/Kv
	WeV0j6vXujanvLdvZWTYMiM6we0hQ9OWNJcPT4JviO9c1a84bZ4s159pcUJuSizFGYmGWsxF
	xYkAawSCVSIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOLMWRmVeSWpSXmKPExsVy+t9jAd2E49OiDDpfcFpc+fqezaJ58Xo2
	izPduRYn+j6wWlzeNYfNYtGyVmaLT8/+sVssXfGW1WL1ysfsDpwesxsusngs2FTqcefaHjaP
	/XPXsHvc7z7O5PF5k5zHghn/WQLYo7hsUlJzMstSi/TtErgy+iYcYSl4zlJx4+EB1gbGT8xd
	jJwcEgImEuufvGYDsYUEdjJK7LkQ2cXIBWR/ZZQ4dfQxWIJNwEpiYvsqRhBbREBV4vulZmaQ
	ImaBbUwSLetmsoMkhAUcJO7ungVmswAV7b9/lAnE5hXQlJi/dxPYIFEBL4kt+9rB4pwCWhIf
	vi9mg9i2i1Hi46cbzBANghI/Jt9jAbGZBeQl9u2fygpha0ms33mcaQIj/ywkZbOQlM1CUraA
	kXkVo2RqQXFuem6xUYFRXmq5XnFibnFpXrpecn7uJkZg8G87rNW/g/HxkvhDjAIcjEo8vA77
	p0UJsSaWFVfmHmKU4GBWEuE9vR0oxJuSWFmVWpQfX1Sak1p8iFGag0VJnJc//1ikkEB6Yklq
	dmpqQWoRTJaJg1OqgdFH0Zfr63OW3Ja6+hzBTZKpJ17q7nq/ZGosw7wpFzcWT0iVnLmZJ+b2
	9owgq1DOH7Xq/8sSz1Y8lPHaqW+Rx/l4DeuOxaUyAaf1LlyaYT57qkG+hpDN7d87G1+1/tvY
	uGlakpC6xbddOivZIyZ6zqzftjjgV62Slb/V+d3qjG1FEvedJXayMiuxFGckGmoxFxUnAgBS
	XbUOegIAAA==
X-CMS-MailID: 20180228151440epcas2p22fd0afcc9cbf3b4523f957ffd97111cf
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180227000432epcas2p1408299421426381f05a548283953b064
X-RootMTR: 20180227000432epcas2p1408299421426381f05a548283953b064
References: <CGME20180227000432epcas2p1408299421426381f05a548283953b064@epcas2p1.samsung.com>
	<1519689860-7421-1-git-send-email-keescook@chromium.org>
	<1712993.EvPlpO244k@amdc3058>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593510325793669190?=
X-GMAIL-MSGID: =?utf-8?q?1593658189445730608?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wednesday, February 28, 2018 04:09:47 PM Bartlomiej Zolnierkiewicz wrote:
> On Monday, February 26, 2018 04:04:17 PM Kees Cook wrote:
> > This is a small series that cleans up struct consw a bit and
> > prepares it for Control Flow Integrity checking (i.e. Clang's
> > -fsanitize=cfi).
> 
> for drivers/video/ parts:
> 
> Acked-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

also I'll be happy to merge all patches through fbdev tree
(if Greg is fine with it and ACKs drivers/usb/ parts)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
