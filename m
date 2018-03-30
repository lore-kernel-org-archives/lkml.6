Return-Path: <ji_hun.kim@samsung.com>
X-Google-Smtp-Source: AIpwx49+5iohm79Or5aWl3eh1ncNHXsvK7tdLdY9ldnV15LDknrqKHTxq1usEl4XPiB+LrCHX+CR
ARC-Seal: i=1; a=rsa-sha256; t=1522381178; cv=none;
        d=google.com; s=arc-20160816;
        b=Sdu6gUduyngvTAK2t1PCdLtOZydhwOCUObpaoKzJ5m50q0H6uD2V/QA0aLmvZ9aodl
         6plM27XZL2rOMzAGYdtjuxuMOCk4AgwvgBKMXEj8cpuBIkPL2FTaFHz99jBnNE8odXCO
         sLRiOuut4awV6GykxiT0F18ghdduklXKtR53EWKkAn6viO9jBKgy8r37Qxg00vrAULTG
         wR7HH3HOIN7spzPezPDm5CZ4eHYhqmYwOlN8VeYIqkA4T5yNKIBB0gmXc1oCsloxtjLq
         6NiPreOcg+0vQzZGxImI9AE4P2OPftQTTND/JuMcQmHAwn3Ttvr1lK8Q4ava1v8nejpT
         yrQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:user-agent:in-reply-to
         :content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=7rh2HVY2Sb68xx9eX+kwuRhXqdxMzRIrKLMeawGwGi0=;
        b=ryGkmqgwYJPDVIA7YzzXQe0cXD2K1RIygyaBU/25xFse42zkLrzpPQc3LOwiO4YlcC
         /OMSBpbpEzJ3KswKYM8AHjVt/Pmzq3vRUD7SIAdM2o9XzOIyBJ2yizb/FZGjuiQIFGjd
         Srcy7JvTcfgO6Af2k/53+GX46JOaW/PVrkoRP4lnrE/WjcaWcoWFtQrt64xXrJzi8Mit
         AbT+VbR1XiYjUouqF5ChU4AZoZmdY+ypKdSooZeSpA9PRwsMShbUPc6Wd68rk1Dw/H83
         pCB2jYk2+cHHwEkzva4SKujSpd+88w6pDOTQDW0WDfNik3bf6isWXvbIi76hOdwvVOzR
         E5mQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=YyJ/tlqv;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=YyJ/tlqv;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.25 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180330033936epoutp021d5a82d48e7f8d07317b2bfb5db58f1f~glZ0jkU292107821078epoutp02X
X-AuditID: b6c32a48-8c1ff70000000ff2-84-5abdb177152d
Date: Fri, 30 Mar 2018 12:39:33 +0900
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: Jia-Ju Bai <baijiaju1990@gmail.com>
Cc: gregkh@linuxfoundation.org, forest@alittletooquiet.net,
	dartnorris@gmail.com, santhameena13@gmail.com, julia.lawall@lip6.fr,
	y.k.oh@samsung.com, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: check for memory allocation
 failures
Message-id: <20180330033933.GA26489@ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
Content-disposition: inline
In-reply-to: <be23acda-38c0-dce3-9c79-8672113f6960@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdljTXLd8494ogy8HDCzWTVzIZHHm/Vkm
	iz1nfrFb3J/wiNWiefF6NotlD04zWmy9JW1xedccNouT2+QttnT9YHXg8mhufM/qcW/fYRaP
	nbPusnvsn7uG3WPvliyPvi2rGD0+b5ILYI9KtclITUxJLVJIzUvOT8nMS7dV8g6Od443NTMw
	1DW0tDBXUshLzE21VXLxCdB1y8wBOk5JoSwxpxQoFJBYXKykb2dTlF9akqqQkV9cYqsUbWho
	pGdoYK5nZGSkZ2Iea2VkClSSkJrRf/42U8FjgYqJf9+wNjB+5+li5OSQEDCR6LvSz9TFyMUh
	JLCDUWLz9AZ2COc7o8SsLwdYYKr+TVnMApHYwChxfesOVgjnJaPEyqXdTCBVLAKqEh9WrwCz
	2QQ0JTZ2X2MEsUUE1CVOL9vFCmIzC3xhlFhyjAPEFhbwl/jX/QJsA6+AtsSxD2uYIWxBiR+T
	77FA1OtInD22jhHClpZ49HcGO4jNKWAr8fblYbAaUQEViSknt7GBHCQh8JxN4u2580wQZ7tI
	XNnYzQphC0u8Or6FHcKWlni2aiMjhF0tseDKDqg3ayRu/l8K1Wss0dtzgRliMZ9Ex+G/QL0c
	QHFeiY42IYgSD4nb1z5BjXSUmPXpKTMkUM4ySkzc/4h5AqPsLCT/zELyzywk/yxgZF7FKJZa
	UJybnlpsVGCiV5yYW1yal66XnJ+7iRGcCLU8djAeOOdziFGAg1GJh1eBZW+UEGtiWXFl7iFG
	CQ5mJRHe8qlAId6UxMqq1KL8+KLSnNTiQ4ymwDiZyCwlmpwPTNJ5JfGGJpYGJmZmhuZGpgbm
	SuK8bQEuUUIC6YklqdmpqQWpRTB9TBycUg2Mu0PuOKRw/Xpa5SdXwrOzuM/o34OmS/v9l3zY
	4Var8O1JpHZm4qNH7w4W3dX4LXbs32Pu+Yr37ndlbzp/Ov306XIH59z/X3s2Hor5WfzIIccz
	0WA3V1AxxyMrtyNC1+feM0v+6B6yaM8akbfr96x1uP7T5vukkv2ilfbP1yk8DHHUv3WiQTQq
	Q4mlOCPRUIu5qDgRAAZLq7WaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsVy+t9jQd3yjXujDP6v5LJYN3Ehk8WZ92eZ
	LPac+cVucX/CI1aL5sXr2SyWPTjNaLH1lrTF5V1z2CxObpO32NL1g9WBy6O58T2rx719h1k8
	ds66y+6xf+4ado+9W7I8+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK6P//G2mgscCFRP/vmFt
	YPzO08XIySEhYCLxb8pili5GLg4hgXWMEhsubmSEcF4ySqzt6WMGqWIRUJX4sHoFE4jNJqAp
	sbH7GiOILSKgLnF62S5WkAZmgS+MEs0/Z7F3MXJwCAv4SlztDgap4RXQljj2YQ0zxNDzjBLr
	Fq5mgkgISvyYfI8FxGYW0JJYv/M4E4QtLfHo7wx2EJtTwFbi7cvDYDWiAioSU05uY5vAyD8L
	SfssJO2zkLQvYGRexSiZWlCcm55bbFRglJdarlecmFtcmpeul5yfu4kRGAXbDmv172B8vCT+
	EKMAB6MSD28F294oIdbEsuLK3EOMEhzMSiK85VOBQrwpiZVVqUX58UWlOanFhxilOViUxHn5
	849FCgmkJ5akZqemFqQWwWSZODilGhjZ2rt4FheoPOU9YqaTkn/n+/uUdMvFCSfPeCrMTNmS
	+sbpn7fG2VXJL69dMDzsuPh++ItQTVf9Gd+O+cuc0OHJPauhIXnmwYTcq/xh7szKc9UM5r9+
	9nBv7uFUAZWMmIdht28eOm6RlTbrwm6NU0nPtFnYj/F/ZPrEnF6qfORJouPXY4Wzk0qVWIoz
	Eg21mIuKEwHtKr1HfgIAAA==
X-CMS-MailID: 20180330033935epcas2p3506493d3249f829de15e1c58116ebff1
X-Msg-Generator: CA
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180330024416epcas2p2f566f43a8f5af8b4ebc17659e3cf0ecf
X-RootMTR: 20180330024416epcas2p2f566f43a8f5af8b4ebc17659e3cf0ecf
References: <CGME20180330024416epcas2p2f566f43a8f5af8b4ebc17659e3cf0ecf@epcas2p2.samsung.com>
	<1522377844-23591-1-git-send-email-ji_hun.kim@samsung.com>
	<be23acda-38c0-dce3-9c79-8672113f6960@gmail.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596328885827783260?=
X-GMAIL-MSGID: =?utf-8?q?1596332366809701878?=
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
But, those freeing function are already placed in the each device_init
functions for allocation fail like below. 

@@ -550,20 +554,29 @@ static void device_init_rd0_ring(struct vnt_private *priv)
+       return 0;
+error:
+       device_free_rd0_ring(priv);
+       return ret;

Would freeing in the vnt_start() be better instead of freeing in
device_init_rd0_ring function?

Best regards,
Ji-Hun
