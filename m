Return-Path: <ji_hun.kim@samsung.com>
X-Google-Smtp-Source: AG47ELu7SyiuylYTJWGUt6WIUquq1VJXil5lz94jIMrS85Imx63VJ/SzXPG8633B37Bgg/+kCaVp
ARC-Seal: i=1; a=rsa-sha256; t=1521433501; cv=none;
        d=google.com; s=arc-20160816;
        b=sz/mkJgUv/x80Rsec77q2gcv0l0cfIlbRqNGd8GRUgVx3CH+0mIfG/0h+lRoByi9Fq
         tPgCWMxkmMPGQS3nislnxLLr0dJlz5x/RkOeh7CoSjnibSfSX1j4sZAX6cL66iHjqnZZ
         k4nwukYX82zSIDnIOMAln1jW2vBaITNEA1oE+bmEXcl53tw0O0lx5yY9ANt0/MB4RklP
         NOxzmHk6Gb84nAlKMIrt9v6jjeRo2Pa+DJORDAilcR38VKfH98sCz1iL6SN7FIvbcBxh
         7iHPediF1yQNou1lTv7ksiXg1TvPM6/o4h2DjDlTKMKCcUXAkk2ubTGpODvxMLlcTOmu
         aheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:dlp-filter:cms-type:user-agent:in-reply-to
         :content-disposition:mime-version:message-id:subject:cc:to:from:date
         :dkim-signature:dkim-filter:arc-authentication-results;
        bh=khbh6xUwak/aqPfxZWO4pxOIrq5DrROH5XFGsNNN7lg=;
        b=pR7ndWzSxLAxkmKIrI/7gqiu3DutOnjuCJTqeI6oHSYHGyf/+6F7RBVw0SY1wNkFuR
         2eV9sZEz7qGhChsB6LMwRn5w0eN1kMQFOsirIoM6pqQl1WKRUm53Q/mW4JN0rifDpPcp
         XS8ssBgNK7kPUvIrb70WSrv10eV6otu++8LU540fA/RLCJrNwwQbVwExBWVm/ASJK/ll
         Ew67M6erb4KFsE5xKzkAJE7A3Y5laBjJ9uTby9npckbWbLp6vX4oTEVk7dFHxkj9WRJe
         ugaEeqQDUgQQl16eBiYBphLl1Vs37wPeMMzqhTref1Uk1M5t6J2cdLC4ehQMjU+5fjKY
         Ig5A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=FxPgzgy1;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.33 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@samsung.com header.s=mail20170921 header.b=FxPgzgy1;
       spf=pass (google.com: domain of ji_hun.kim@samsung.com designates 203.254.224.33 as permitted sender) smtp.mailfrom=ji_hun.kim@samsung.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=samsung.com
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180319042459epoutp035ab6b26987831697a2e128b786febee9~dN7TlC6Ti2919229192epoutp03I
X-AuditID: b6c32a36-c91ff70000001028-14-5aaf3b99da41
Date: Mon, 19 Mar 2018 13:24:57 +0900
From: Ji-Hun Kim <ji_hun.kim@samsung.com>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: mchehab@kernel.org, gregkh@linuxfoundation.org,
	arvind.yadav.cs@gmail.com, ji_hun.kim@samsung.com,
	linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: Re: [PATCH] staging: media: davinci_vpfe: add error handling on
 kmalloc failure
Message-id: <20180319042457.GB2915@ubuntu>
MIME-version: 1.0
Content-type: text/plain; charset="us-ascii"
Content-disposition: inline
In-reply-to: <20180316083234.yq7a4rx6w35amflu@mwanda>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgk+LIzCtJLcpLzFFi42LZdljTQHem9foog71TrS2u9S5ktnj9bzqL
	xZ4zv9gtmhevZ7PoP72d0WLrLWmLy7vmsFn0bNjKarFs0x8mB06Pe/sOs3jsnHWX3WPTqk42
	j/1z17B7fHx6i8Wjb8sqRo/Pm+QC2KNSbTJSE1NSixRS85LzUzLz0m2VvIPjneNNzQwMdQ0t
	LcyVFPISc1NtlVx8AnTdMnOALlNSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX2CpFGxoa6Rka
	mOsZGRnpmZjHWhmZApUkpGbseVVa0KBc8bH3ClsD40TRLkZODgkBE4kz724xdTFycQgJ7GCU
	uHR4EitIQkjgO6PEsiYuuKJV26GKdjNK3J/5mwXCecko8f7zRzaQKhYBVYkDp64xgthsApoS
	G7shbBEBHYnLnT/YQWxmgceMEj0LLEBsYYE4iTv/bjKB2LwCWhKz2qYyQ9iCEj8m32OBqNeR
	OHtsHSOELS3x6O8MsDmcAqYSH6bsALtUVEBFYsrJbWwgB0kIXGeT+LJ7EVADB5DjIrFvlTvE
	B8ISr45vYYcIS0tcOmoLEa6WWHBlBwuEXSNx8/9SJgjbWKK35wIzxFo+iXdfe1ghWnklOtqE
	IEo8JDqW3WCFsB0lHt34DA2So4wS15vPs05glJ2F5JtZSL6ZheSbBYzMqxjFUguKc9NTiw0L
	jPSKE3OLS/PS9ZLzczcxglOfltkOxkXnfA4xCnAwKvHwOhxdFyXEmlhWXJl7iFGCg1lJhPfp
	FaAQb0piZVVqUX58UWlOavEhRlNgjExklhJNzgem5bySeEMTSwMTMyNTU0MDCxMlcd6AAJco
	IYH0xJLU7NTUgtQimD4mDk6pBsakS96hh10UWja7lb44/NH44Kf8Q4of3red/nE5bHm2SYp1
	hkbFav0D3zoLd776WR+vGyMnstn/6lq+TXKropeV9tediTqqHcj4dnHvrv8nsr9bOqxvCl9y
	TdA5KnwiR5vwlJgLa9O0HbRnPNRXib6idr5oZ+Hq/SvEdmVcvsT3MMjrY552oIESS3FGoqEW
	c1FxIgCcIKaAkwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBLMWRmVeSWpSXmKPExsVy+t9jAd2Z1uujDNafUrO41ruQ2eL1v+ks
	FnvO/GK3aF68ns2i//R2Routt6QtLu+aw2bRs2Erq8WyTX+YHDg97u07zOKxc9Zddo9NqzrZ
	PPbPXcPu8fHpLRaPvi2rGD0+b5ILYI/isklJzcksSy3St0vgytjzqrSgQbniY+8VtgbGiaJd
	jJwcEgImEmdWbWfqYuTiEBLYySjx8+lRZgjnJaPErtffGEGqWARUJQ6cugZmswloSmzshrBF
	BHQkLnf+YAdpYBZ4zCjR8PcSE0hCWCBO4s6/m2A2r4CWxKy2qVBTjzNKrH20mREiISjxY/I9
	FhCbGaho/c7jTBC2tMSjvzPYQWxOAVOJD1N2sILYogIqElNObmObwMg/C0n7LCTts5C0L2Bk
	XsUomVpQnJueW2xUYJiXWq5XnJhbXJqXrpecn7uJERj+2w5r9e1gvL8k/hCjAAejEg+vw9F1
	UUKsiWXFlbmHGCU4mJVEeJ9eAQrxpiRWVqUW5ccXleakFh9ilOZgURLnvZ13LFJIID2xJDU7
	NbUgtQgmy8TBKdXAmLek9sb0ya+ljnIJzn/BeVFspT/bjRPOER3fPluXpN4Q77HcdNktuLDv
	790FVx03TunxY69aeVDV0u5Ir/HEOesCpuu+E5Q3eSqqbn+0he3aJZbNvw8vfTXZ+OBjD2NX
	R9WLavdvPtoyXefunXCve4INebeF/jAGOt24s++q1KzcMtFfxSV7IpRYijMSDbWYi4oTAYYm
	XUR7AgAA
X-CMS-MailID: 20180319042457epcas1p1a4cd48add460a6f07111e5fb1161a75d
X-Msg-Generator: CA
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20180316045841epcas2p34dc11231c65e2032e88ac7138db2daee
X-RootMTR: 20180316045841epcas2p34dc11231c65e2032e88ac7138db2daee
References: <CGME20180316045841epcas2p34dc11231c65e2032e88ac7138db2daee@epcas2p3.samsung.com>
	<1521176303-17546-1-git-send-email-ji_hun.kim@samsung.com>
	<20180316083234.yq7a4rx6w35amflu@mwanda>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595068985971756322?=
X-GMAIL-MSGID: =?utf-8?q?1595338655452845074?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 11:32:34AM +0300, Dan Carpenter wrote:
> On Fri, Mar 16, 2018 at 01:58:23PM +0900, Ji-Hun Kim wrote:
> > There is no failure checking on the param value which will be allocated
> > memory by kmalloc. Add a null pointer checking statement. Then goto error:
> > and return -ENOMEM error code when kmalloc is failed.
> > 
> > Signed-off-by: Ji-Hun Kim <ji_hun.kim@samsung.com>
> > ---
> >  drivers/staging/media/davinci_vpfe/dm365_ipipe.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
> > index 6a3434c..55a922c 100644
> > --- a/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
> > +++ b/drivers/staging/media/davinci_vpfe/dm365_ipipe.c
> > @@ -1280,6 +1280,10 @@ static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
> >  
> >  			params = kmalloc(sizeof(struct ipipe_module_params),
> >  					 GFP_KERNEL);
> > +			if (!params) {
> > +				rval = -ENOMEM;
> > +				goto error;
>                                 ^^^^^^^^^^
> 
> What does "goto error" do, do you think?  It's not clear from the name.
> When you have an unclear goto like this it often means the error
> handling is going to be buggy.
> 
> In this case, it does nothing so a direct "return -ENOMEM;" would be
> more clear.  But the rest of the error handling is buggy.
Hi Dan,
I appreciate for your specific feedbacks. It looks more clear. And I'd
like you to see my question below. I will send the patch v2.

> 
>   1263  static int ipipe_s_config(struct v4l2_subdev *sd, struct vpfe_ipipe_config *cfg)
>   1264  {
>   1265          struct vpfe_ipipe_device *ipipe = v4l2_get_subdevdata(sd);
>   1266          unsigned int i;
>   1267          int rval = 0;
>   1268  
>   1269          for (i = 0; i < ARRAY_SIZE(ipipe_modules); i++) {
>   1270                  unsigned int bit = 1 << i;
>   1271  
>   1272                  if (cfg->flag & bit) {
>   1273                          const struct ipipe_module_if *module_if =
>   1274                                                  &ipipe_modules[i];
>   1275                          struct ipipe_module_params *params;
>   1276                          void __user *from = *(void * __user *)
>   1277                                  ((void *)cfg + module_if->config_offset);
>   1278                          size_t size;
>   1279                          void *to;
>   1280  
>   1281                          params = kmalloc(sizeof(struct ipipe_module_params),
>   1282                                           GFP_KERNEL);
> 
> Do a direct return:
> 
> 				if (!params)
> 					return -ENOMEM;
> 
>   1283                          to = (void *)params + module_if->param_offset;
>   1284                          size = module_if->param_size;
>   1285  
>   1286                          if (to && from && size) {
>   1287                                  if (copy_from_user(to, from, size)) {
>   1288                                          rval = -EFAULT;
>   1289                                          break;
> 
> The most recent thing we allocated is "params" so lets do a
> "goto free_params;".  We'll have to declare "params" at the start of the
> function instead inside this block.
> 
>   1290                                  }
>   1291                                  rval = module_if->set(ipipe, to);
>   1292                                  if (rval)
>   1293                                          goto error;
> 
> goto free_params again since params is still the most recent thing we
> allocated.
> 
>   1294                          } else if (to && !from && size) {
>   1295                                  rval = module_if->set(ipipe, NULL);
>   1296                                  if (rval)
>   1297                                          goto error;
> 
> And here again goto free_params.
> 
>   1298                          }
>   1299                          kfree(params);
>   1300                  }
>   1301          }
>   1302  error:
>   1303          return rval;
> 
> 
> Change this to:
> 
> 	return 0;
Instead of returning rval, returning 0 would be fine? It looks that should
return rval in normal case.

> 
> free_params:
> 	kfree(params);
> 	return rval;
> 
>   1304  }
> 
> regards,
> dan carpenter
> 
> 
Thanks,
Ji-Hun
