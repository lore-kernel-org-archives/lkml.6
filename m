Return-Path: <sw0312.kim@samsung.com>
X-Google-Smtp-Source: AG47ELu8qPBNYQTyLNfOCBvvQN+OUYI6VlBVMbafAWQLA3G0Z2/O1MlgrLRSsYblH61EGeWCVzei
ARC-Seal: i=1; a=rsa-sha256; t=1522135902; cv=none;
        d=google.com; s=arc-20160816;
        b=i1ZzND6rmJd1SDwXLHIJOB+dmwOiDcSlymFG6JEeEQnUISY6xmOz6DB7lQ9omlemew
         d3547YwThyL0PciDE3wK3eCpn2xjpncXEneeB93fHNZ0zwHbtOx/Yf/Rxqpll8t//IOv
         2+3uoLRgPDy5UOI99YIJgZ6EP8GUFXrGA3kZQqXVVKjSyRtsS+2EiuT5okJCl4Y2evj3
         BGrXUM4sT0nyKVM4O0MkToo5EwvKmtzejWD/vh6nmDB3A99cA6hJPZUBTbbfQNBcxHaN
         vUW5bLy5E8Up55ixlRbT7Nzx39UFidB5g5JmoNIMS98nKeey9f9iTqjIUYcyOEzigS9y
         o5tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:in-reply-to:subject:cc:to:user-agent
         :reply-to:from:date:message-id:content-transfer-encoding
         :mime-version:dkim-signature:dkim-filter:arc-authentication-results;
        bh=NtSosFcg0pS8NQz0hmGJZEjuMjcJVkz16gf7ko0us9s=;
        b=lLKYpjzJcHGDGj2dZFpyd5dg5aGzokZziqq6YmDuNm3d+IIBAZg0Haz1ZzRFPFzX6f
         BTMh3Jm/Iv38Q36tc6hz16dwzJq5S1loOYkUfMbK/XBc+8QjKkq1TnApaXfl1S/S5G5u
         X32ZXSVt2R2yZCkuvue12GR0ULXTilH9i1dsTj/QCNiOx0NPhjrsgRQ7DvedmWhMAcnS
         lhbtCgooNkjdqVMwsKVh9tZTrascsp63tAnRhVMc8lONSoUgp7kYQkpkXVFGr811q4Of
         fxDe3T4dXv/ElfEo50N2/2me0p8xwyrsx1AfMG2QPnKVNozsLmX3BKGVn6Q+PF/YGuJv
         sjhQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=eL5JcTkv;
       spf=pass (google.com: domain of sw0312.kim@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=sw0312.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=eL5JcTkv;
       spf=pass (google.com: domain of sw0312.kim@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=sw0312.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180327073140epoutp02ff36c09f9431da304597a6cb3fdb5379~ftoloD6u_0732207322epoutp02g
X-AuditID: b6c32a39-591ff70000000ff4-06-5ab9f35b6903
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Message-id: <5AB9F365.2030309@samsung.com>
Date: Tue, 27 Mar 2018 16:31:49 +0900
From: Seung-Woo Kim <sw0312.kim@samsung.com>
Reply-to: sw0312.kim@samsung.com
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:16.0) Gecko/20121011
	Thunderbird/16.0.1
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mchehab@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux 3.18.102
In-reply-to: <20180327070528.GB31193@kroah.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTYRTGeXfv7q7m4m1mvSzQcSFJy7U7N91CS1FkkNYk6o9V2MVddOo+
	uHeKRoT05RrhR5rEKinSMhO0kWEZSrOthErQPs0khMQs/EisSKO23aL+e97n/M57OA+HxGQf
	xHLSYnOynI0po4hI/M5ggirpwOJdk+pTlO741S5CN3rvIqG75l0R6c43fiQycIO34zRhGLjU
	KTHU3u4AhkVvrBE3sWnFLGNmOQVrK7SbLbaidGrnnoKsAm2Kik6i9bpUSmFjrGw6lZ1rTMqx
	lAUnUooKpqw8aBkZnqe2bk/j7OVOVlFs553p1H6aVitpVapSrVYrNckHt6m1QeQQW3xhoRVz
	tK+ufO9/CqrB0Co3iCAR1KCWH9NiN4gkZbAXoHf1T3Dh8Q2gibbJYIUMU03djOD3ATRZO4mH
	uqVwDfreOIGHGAzGoYcjpSEbgwmop69LIvATAJ0dGhYJfCLyPB4DIY3DjWj4ghcLaQJuQQOt
	y+KQlkEFet4QkIR0DNyHzj+oC/Nr4Sb00T+GCwM0yP2lJfxnNNyAXnlHwzoCbkVN015RaDCC
	3QS6v+TChDWzUXNPn0TQ0Wjm0W2JsNgGNOJPF+wagK69NAq9TQDde+EVCYVkNHXFLRIGr0az
	S2f+hCJFrlMyATGgkYWBP3gmqm6+hQnLBwCactWK60Gs57+8PP/y8vyX12WAdYB1rIO3FrE8
	7dAqecbKl9uKlIV2qxeETyxR3wsCz3J9AJKAipJmEHdNMjFTwVdZfQCRGLVWWtoWtKRmpuow
	y9kLuPIylvcBbTDuBkweU2gPHqzNWUBr9CpNijp4XXqaptZLjcZskwwWMU62lGUdLPe3T0RG
	yKsBId8LseXuvGNpu8yNBP+2t8qvz2svybmZWpfnKglQhl89nl1+y6Uc0LbSkXk0f7dl7qRb
	YYjuSxqJnHC94TbP53fWnDB9bq6Lm3tN3pj/2nqkZMe5fnF8QmXAVz8+HnD3+11j9EyJ2vxz
	3iSPih+6ftGXZXNlzOYa4aCDo3C+mKETMY5nfgNXccWneAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t9jAd3ozzujDGZ361k0L17PZnF51xw2
	i2Wb/jBZzJj8ks2BxWPTqk42j/1z17B79G1ZxejxeZNcAEsUl01Kak5mWWqRvl0CV8bsj0uY
	C1bwVTw4epaxgfEkdxcjB4eEgInElA2JXYxcHEICOxklpm+ZwdzFyMnBKyAo8WPyPRaQGmYB
	eYkjl7JBwswC6hKT5i1ihqh/wChx4Mozdoh6LYlZJ24xgtgsAqoS52dvApvDJqAjsX/Jb1YQ
	W0hAQeLKxGPsIDNFBcIkdm5OBwmLCGhIvDx6iwVivolE16d5TCC2sIC0xPVNl5kgdp1glHi+
	YRLYfE4BfYkpLzYxTWAUmIXk1FkIp85CcuoCRuZVjJKpBcW56bnFRgWGeanlesWJucWleel6
	yfm5mxiBAbztsFbfDsb7S+IPMQpwMCrx8M7g2BklxJpYVlyZe4hRgoNZSYQ3eylQiDclsbIq
	tSg/vqg0J7X4EKM0B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6pBkZrx+exclsbONIehJ7S
	umJ4UmyKbqRY6AWDpHWBpuffZzN1ab8Uyirg7lrqVDbjt9pHUatd75ZdiVrAWrh+5h933iuz
	RPJvP+zQ3d22XYVb1ZZ5hkb+KQm/wLNXLPOKjEtjzeZ8j2gozl/f0FsRWSIrHtMakl/TMI07
	MlusMdfobeOSAI1PSizFGYmGWsxFxYkAapWcXlwCAAA=
X-CMS-MailID: 20180327073139epcas1p1f9b59fdcae2d33a6c89bc1eedbb4318c
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180325090010epcas1p2864bb6fe3cbc420bc71eb0e7f1c847f1
X-RootMTR: 20180325090010epcas1p2864bb6fe3cbc420bc71eb0e7f1c847f1
References: <CGME20180325090010epcas1p2864bb6fe3cbc420bc71eb0e7f1c847f1@epcas1p2.samsung.com>
	<20180325085952.GA31575@kroah.com> <5AB9A111.1080105@samsung.com>
	<20180327070528.GB31193@kroah.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcSW1wb3J0YW50Ig==?=
X-GMAIL-THRID: =?utf-8?q?1595911656234901027?=
X-GMAIL-MSGID: =?utf-8?q?1596075175746855812?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 2018년 03월 27일 16:05, Greg KH wrote:
> On Tue, Mar 27, 2018 at 10:40:33AM +0900, Seung-Woo Kim wrote:
>> Hello,
>>
>> Until 3.18.102, it looks like following patch series for v4l2 seems missed.
>>
>> 273caa2 media: v4l2-compat-ioctl32.c: make ctrl_is_pointer work for subdevs
>> a1dfb4c media: v4l2-compat-ioctl32.c: refactor compat ioctl32 logic
>> d83a824 media: v4l2-compat-ioctl32.c: don't copy back the result for
>> certain errors
>> 169f24c media: v4l2-compat-ioctl32.c: drop pr_info for unknown buffer type
>> a751be5 media: v4l2-compat-ioctl32.c: copy clip list in put_v4l2_window32
>> b8c601e media: v4l2-compat-ioctl32.c: fix ctrl_is_pointer
>> 8ed5a59 media: v4l2-compat-ioctl32.c: copy m.userptr in put_v4l2_plane32
>> 333b1e9 media: v4l2-compat-ioctl32.c: avoid sizeof(type)
>> 486c521 media: v4l2-compat-ioctl32.c: move 'helper' functions to
>> __get/put_v4l2_format32
>> b7b957d media: v4l2-compat-ioctl32.c: fix the indentation
>> 3ee6d04 media: v4l2-compat-ioctl32.c: add missing VIDIOC_PREPARE_BUF
>> 181a4a2 media: v4l2-ioctl.c: don't copy back the result for -ENOTTY
> 
> That is correct.
> 
>> Any plan to apply the series?
> 
> Do you have a backported version of this series that will apply to that
> kernel tree?  If so, I'll be glad to apply it but I'm pretty sure the
> reason I did not apply them was because they did not apply correctly.

I dit not do it myself. I just checked the series is applied on other
stable trees.

> 
> Also, are you even sure you need these patches for 3.18.y?  Do you have
> a v4l2 device that relies on these fixes?

I've just expected A-34624167 is also fixed from other ARM64 devices
based on 3.18.y.

Best Regards,
- Seung-Woo Kim

> 
> thanks,
> 
> greg k-h
> 
> 
> 

-- 
Seung-Woo Kim
Samsung Research
--
