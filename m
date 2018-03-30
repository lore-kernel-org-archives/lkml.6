Return-Path: <ji_hun.kim@samsung.com>
X-Google-Smtp-Source: AIpwx4+FRpJU0OiN67MUszmgiMdVUwki8Ofo3+UWMSxNsU245defYFEsYYiPM3CJPyCI2ESw6OlD
ARC-Seal: i=1; a=rsa-sha256; t=1522381808; cv=none;
        d=google.com; s=arc-20160816;
        b=r2jKBFBBt8cBVB0y6puG00N6ZjnGGDe1fne7Tca67GOneXTD/2E7Pq/ZgdJlfX2mon
         rhN14BpgToD6DJcP/O45I/p8BN/eknt1F7Da2OJ1wuc6kujgiN1RgYy48W4fBJLsL4Oj
         1b7KYWprITR/KG/PbI/Hcv7PEUShOLqZOSFMDwlutnd5tBebzqqEhgUugUoh3w8GqKwr
         MER9LjlElr3h0GvM+OAwAt9ECBHGR46dDEnT2emnUhkBnwXgrXxqbxYx9u7f7jkx45UA
         3R1XqCSZ1VUlBOxXp2FiipElY7xGutC+++S2KUwFWdWTGXWh0dK1wzAw4dL7wlnLHX8q
         z9zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:user-agent:in-reply-to
         :content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=yYsfUMlsviuVsggEr+WRUlfm0y+tUrUggjry9dfyWtw=;
        b=iDJS7RSA+aVLpjI4g0OwuHzcP+e8i9X4ZOTfRHjbah22z9ETguYft+S1WiXmwfXlNq
         xKUPpfwxEK7rWFeHVd91tj7imULRR3vZMrT/FVUWVK4Hg+kkgWsMFjv63cFwE88Zgqeg
         tOIsLzYeFIagTD6RNyhdykzdHd3E4RLAY0LaSaOTKxvm6idXIMPnfzvhNchLN5Y93HMO
         hqaoF9FDSGVNMOqRCM1d6nzwDyiJWmUlgZtShMyzFstzUuo7ve+Fuz+PqQTfpl22fsPR
         QT0rT4yxS9q73B4vu7CxZCZw8mR+f9gUyKZu2ddI40kuKgfP+KKYkpp+pfHJJLXb2E8L
         9ZJA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=hsua0D93;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=hsua0D93;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180330035007epoutp02ec7f601e99554045a555970dd95e5dbf~gljAUYLHc2758927589epoutp02j
X-AuditID: b6c32a39-579ff70000000ff4-eb-5abdb3eeeec3
Date: Fri, 30 Mar 2018 12:50:03 +0900
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: gregkh@linuxfoundation.org, forest@alittletooquiet.net,
	dartnorris@gmail.com, santhameena13@gmail.com, julia.lawall@lip6.fr,
	y.k.oh@samsung.com, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: check for memory allocation
 failures
Message-id: <20180330035003.GA27619@ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
Content-disposition: inline
In-reply-to: <be23acda-38c0-dce3-9c79-8672113f6960@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpik+LIzCtJLcpLzFFi42LZdljTQPfd5r1RBoevCFmsm7iQyeLM+7NM
	FnvO/GK3uD/hEatF8+L1bBbLHpxmtNh6S9ri8q45bBYnt8lbbOn6werA5dHc+J7V496+wywe
	O2fdZffYP3cNu8feLVkefVtWMXp83iQXwB6VapORmpiSWqSQmpecn5KZl26r5B0c7xxvamZg
	qGtoaWGupJCXmJtqq+TiE6DrlpkDdJySQlliTilQKCCxuFhJ386mKL+0JFUhI7+4xFYp2tDQ
	SM/QwFzPyMhIz8Q81srIFKgkITVj2d5FrAW7+SpmTPzC0sDYzd3FyMkhIWAi0bXyKFMXIxeH
	kMAORomWzY/ZQRJCAt8ZJXp+WXYxcoAV/TwpDlGzgVHi7+Q7rBDOS0aJU3uOsoIUsQioSjxa
	mA3SyyagKbGx+xojiC0ioC5xetkuVhCbWeALo8SSYxwgtrCAv8S/7hcsIDavgLbE/1dT2SFs
	QYkfk++xQNTrSJw9to4RwpaWePR3BlgNp4CtxNuXh8FqRAVUJKac3MYGco+EwGM2iab1PewQ
	R7tILP5iBvGksMSr41ugwtISl47aQoSrJRZc2cECYddI3Py/lAnCNpbo7bnADLGWT+Ld1x5W
	iFZeiY42IYgSD4nb1z6xQ9iOErM+PWWGhMhZRomJ+x8xT2CUnYXkm1lIvpmF5JsFjMyrGMVS
	C4pz01OLDQtM9YoTc4tL89L1kvNzNzGC05+W5Q7GY+d8DjEKcDAq8fAqsOyNEmJNLCuuzD3E
	KMHBrCTCWz4VKMSbklhZlVqUH19UmpNafIjRFBghE5mlRJPzgak5ryTe0MTSwMTMyNTU0MDC
	REmcNyDAJUpIID2xJDU7NbUgtQimj4mDU6qB8bSjrtmqT5scK0/kpl/lS4uZFcTeOmdSh4fB
	z5NL9rhtnJRp/yT6+QGTSwtsE6bbR/s/kRbQXq39wYpv3c2nh34dPHb06EFpeS3BD3rnb0/r
	lD0+nav42ocvjxpuvZrzOPS1vovPTfeXJg4XjiyIqQixZNWMPVx1Y3Pc6lmPxLM2B6WxyV/3
	rFBiKc5INNRiLipOBACWxw7WlQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t9jQd23m/dGGdyfpWGxbuJCJosz788y
	Wew584vd4v6ER6wWzYvXs1kse3Ca0WLrLWmLy7vmsFmc3CZvsaXrB6sDl0dz43tWj3v7DrN4
	7Jx1l91j/9w17B57t2R59G1ZxejxeZNcAHsUl01Kak5mWWqRvl0CV8ayvYtYC3bzVcyY+IWl
	gbGbu4uRg0NCwETi50nxLkZODiGBdYwSW5bndjFyAdkvGSW+TvnMBFLDIqAq8WhhNkgNm4Cm
	xMbua4wgtoiAusTpZbtYQeqZBb4wSjT/nMUOUi8s4CtxtTsYpIZXQFvi/6up7BAzzzNKrFu4
	mgkiISjxY/I9FhCbWUBLYv3O40wQtrTEo78z2EFsTgFbibcvD4PViAqoSEw5uY1tAiP/LCTt
	s5C0z0LSvoCReRWjZGpBcW56brFRgWFearlecWJucWleul5yfu4mRmD4bzus1beD8f6S+EOM
	AhyMSjy8FWx7o4RYE8uKK3MPMUpwMCuJ8JZPBQrxpiRWVqUW5ccXleakFh9ilOZgURLnvZ13
	LFJIID2xJDU7NbUgtQgmy8TBKdXAKFG4f7mn1XSVC5czjk6v/Wxjwp6qyVl7c+Hj2LstNx66
	+2XVlma0LaxX+1kS4TXLsiy5KuKambDZg2Zph+7WFV05xbKcqXdDX1tLlm55dkJwx+8q6bsz
	64/zLg3kTZ7z/OaBIJHirVlLnO1u6EZZh7434vaRmBSwKuvEpwtP5az0jsapHvFUYinOSDTU
	Yi4qTgQAeC3DdHsCAAA=
X-CMS-MailID: 20180330035005epcas1p37d4230f41bfde386b0d9cb7d76504469
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180330024416epcas2p2f566f43a8f5af8b4ebc17659e3cf0ecf
X-RootMTR: 20180330024416epcas2p2f566f43a8f5af8b4ebc17659e3cf0ecf
References: <CGME20180330024416epcas2p2f566f43a8f5af8b4ebc17659e3cf0ecf@epcas2p2.samsung.com>
	<1522377844-23591-1-git-send-email-ji_hun.kim@samsung.com>
	<be23acda-38c0-dce3-9c79-8672113f6960@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596328885827783260?=
X-GMAIL-MSGID: =?utf-8?q?1596333027811654012?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 30, 2018 at 11:15:03AM +0800, Jia-Ju Bai wrote:
> 
> 
> On 2018/3/30 10:44, Ji-Hun Kim wrote:
> >@@ -1165,10 +1205,18 @@ static int vnt_start(struct ieee80211_hw *hw)
> >  	}
> >  	dev_dbg(&priv->pcid->dev, "call device init rd0 ring\n");
> >-	device_init_rd0_ring(priv);
> >-	device_init_rd1_ring(priv);
> >-	device_init_td0_ring(priv);
> >-	device_init_td1_ring(priv);
> >+	ret = device_init_rd0_ring(priv);
> >+	if (ret)
> >+		goto error;
> >+	ret = device_init_rd1_ring(priv);
> >+	if (ret)
> >+		goto error;
> >+	ret = device_init_td0_ring(priv);
> >+	if (ret)
> >+		goto error;
> >+	ret = device_init_td1_ring(priv);
> >+	if (ret)
> >+		goto error;
> >  	device_init_registers(priv);
> >@@ -1178,6 +1226,8 @@ static int vnt_start(struct ieee80211_hw *hw)
> >  	ieee80211_wake_queues(hw);
> >  	return 0;
> >+error:
> >+	return ret;
> >  }
> 
> This code will lead to memory leaks when device_init_rd1_ring()
> fails, because the memory allocated by device_init_rd0_ring() is not
> freed.
> 
> I think this one will be better:
>     ret = device_init_rd0_ring(priv);
>     if (ret)
>         goto error_init_rd0_ring;
>     ret = device_init_rd1_ring(priv);
>     if (ret)
>         goto error_init_rd1_ring;
>     ret = device_init_td0_ring(priv);
>     if (ret)
>         goto error_init_td0_ring;
>     ret = device_init_td1_ring(priv);
>     if (ret)
>         goto error_init_td1_ring;
>     ......
> error_init_td1_ring:
>     device_free_td0_ring(priv);
> error_init_td0_ring:
>     device_free_rd1_ring(priv);
> error_init_rd1_ring:
>     device_free_rd0_ring(priv);
> error_init_rd0_ring:
>     return ret;
> 
> 
> Best wishes,
> Jia-Ju Bai
> 
> 
Oh, sorry, I got what you said. Yes, you are right. I am going to make patch v4. Thanks!

Best regards,
Ji-Hun
