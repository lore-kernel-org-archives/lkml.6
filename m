Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2958128-1525995656-2-14283868530121648066
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES enrofr,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525995655; b=IQxKkhis1gjuxD+yDjPvTLhRiEc1EMNvUA1UVxptrLohgqMzFY
    IVbdY37hv6DOkh3XZ7KXC49SgrAjZWsiT7Qs5bdpi8OJrUBR87G+sJp0jh1XPiOZ
    pXl6i9lohV/V7RV37V3Lhi+22Mbhrvk1LtUD0SV1RonCKoEEAwFLauFGn/IyT2kn
    30K0J12IaQyaGcSM7Q/2KtiY6aUmJ9vXUZAnTbTQGySmL0ofwL6sYCkn/azLZKtC
    sW8pPu6+jDpFvvq9xRvjMKRFltxePiUrFqcO57Enbfa41iuTcltYkuzGpuJ78vvG
    7lihNc7ywNnfW1BP+5gSX3D18zV+249Mshmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:message-id:in-reply-to
    :references:subject:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:content-type
    :content-transfer-encoding:sender; s=fm2; t=1525995655; bh=JzlW3
    TwgRtFuJ5z0KQxt8PMkYCM+pZ7qLN8wcbd7vUo=; b=Oo8t28om3RPFJgfKkhCm0
    nchkSApAz1ly6tIlpqjZxMlIGc5kR25Ah6kj2K9OQrcEoDqODApk/focLr8vIjYw
    M1D8CUe1gP0yTCBXJUamOBsFdZGLysNFMiUv1kAvWY77NOj5VTCeRMM9o2oCw5LS
    iR9fWTLsTWd2w0kDVlyFE31ytwQRl3Hc8CPjSIuWOigMPLhfTiTg4aIxlx/yanad
    xtS1kM45UEnGd6CtCOp+ylhMASbXFOXI2LKCv4I7CDoF8wQvA6E2mgvaoXOrTUF0
    h36NwWCF3v8s1kWMfq08OjkUTeJKrKfnQpJrKK1sKA9on8DifYLgZ7m2Ceb4TvFG
    g==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i2se.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=i2se.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-80 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=i2se.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=i2se.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-80 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBtJ1w+RrYlG2i8ahUvePwbOVmty53bugJ5B1/fWjseJ2BKvGct1Zhkx9gMzMQfMo2ixHauQOZ5Wj9LOjuMgRM5gSBLCZRxIeBYTYDnkR7kMeScOlIwO
    EF5jbwF3a/zr4EpL4rNukawXX0rGsbUIXY3Gp85Ouurr0liYpCcKI3+RcBXspgxk6bBmjqPP7II45m0ToSfReLI7aALvLE5SshWJvpoEERneIndBEht3d/oY
    refdbS7R16X/+9WuDS+kdA==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=kIo7DnY5WRu98hpln7do/g==:117
    a=kIo7DnY5WRu98hpln7do/g==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=-VAfIpHNAAAA:8 a=DDOyTI_5AAAA:8
    a=YfnTFZnIXjZt5bPkhEoA:9 a=CjuIK1q_8ugA:10 a=srlwD-8ojaedGGhPAyx8:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
Date: Fri, 11 May 2018 01:40:21 +0200 (CEST)
From: Stefan Wahren <stefan.wahren@i2se.com>
To: linux-rpi-kernel@lists.infradead.org, Eric Anholt <eric@anholt.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Message-ID: <1544770503.215491.1525995621129@email.1und1.de>
In-Reply-To: <20180510233107.1684-1-eric@anholt.net>
References: <20180510233107.1684-1-eric@anholt.net>
Subject: Re: [PATCH] staging: bcm2835-camera: Replace open-coded idr with a
 struct idr.
MIME-Version: 1.0
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev28
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:iguvxLGMbmL7O60eDcD9VfLyOTgjh3VyUR93WcQwSJPrMKmBfZJ
 W3RDCPGFpzrXGKbYKthZWE2pEiVJphFXREFl1w39AWAw4odNiAr2hch+mLwpP2UH3jk1U6q
 4OsxD+VMPdsXx+GzHyIRn09ON3v4f1nHsfqwjYH7uVVWiIYaYIPDM3LnYC+3qPdJrbkDvAZ
 6gD7Cu5jWxKh0H5q+tj8w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UHDTuhojdU4=:JSk7j7HKojpked2MDSBIh/
 XAOueRuKTUn8by0NQ0Zdy1YXmROAwKxRJiEWsF1iARCqtqCtzodlKY6sjP4wZJPqhkZFjcqZW
 exLopiS6IbBhc06X5ksn9FzrcealiGvWV0YTbfUHU/nN9DCYGPmt5bX7rmf0V/laEISUoBdLk
 0i4D5sSavQLn5G3UzmuRnQufjDGyivC3ITuQUCVp1nWE16RjMR5frGi3H/gRp3Xu3l/bHx7SM
 Uu2vKnxaFH2b3RVY7GwGUByK3Xeq2UizwP3aRFH6hc/Eh67NreYNWqqrsiUkv2p8odAhwTHs/
 Bz82z0/wB5p1PZwCO+9mgmaBClIBNJaOybJgm0svrLcVBicvHLQy7jLABSLFybQtgkX7Wx/mi
 QXfSgGuV8+03jYCUHKXv9meQRNQXR6ScmlDj3YH95qgl3iW/LrP2lvqlzoauk+W/kujVUaqjU
 rOUv0/2pzx3/z7l4bH5E7aA6G4EITd5TMhaZB+zDRoh2Te8oNN1OSaeo35+AM5OTFONeznw13
 D3IaaZTAoyEiFa8r6jnvS5I49o2KwXOMrKD1ayFsDMgUcdNONIK99ZP3MZh6XivOzRptdFygo
 FtZ86Jknl66Ym/F9AwRv8z9wiPQgpCH9nignmO58dVsItr59a43Ksr/jFqE+Alymivk7uzyp8
 IB1BmqbJj9digo+vkQHMotuuxLb2bSlGuFuxD0D7N6echg7F+cEqTWeZbEdmcHskDrZwMRYFA
 WTNH4jMhSKlFHW0NE22X1tAZdYg5/djOIaVc5DJPbTr5wlDtLvgIOk7bCW0qc10BwkdAtzIn5
 74/xZXkNhbRtlvca5kkgNJIIE5+mCHENA5SLjKfja4EFJ+Bh4s8ljhnZVPM3vH6QmKe4/DSlz
 8CooNdneGsZaG2gCG3MGdLttqsiEJ+ZGPxvGmSLng=
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Eric,

> Eric Anholt <eric@anholt.net> hat am 11. Mai 2018 um 01:31 geschrieben:
> 
> 
> We just need some integer handles that can map back to our message
> struct when we're handling a reply, which struct idr is perfect for.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../vc04_services/bcm2835-camera/mmal-vchiq.c | 135 ++++--------------
>  1 file changed, 31 insertions(+), 104 deletions(-)
> 
> diff --git a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
> index 3a3b843fc122..f0dac6440cfb 100644
> --- a/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
> +++ b/drivers/staging/vc04_services/bcm2835-camera/mmal-vchiq.c
> @@ -21,7 +21,6 @@
>  #include <linux/slab.h>
>  #include <linux/completion.h>
>  #include <linux/vmalloc.h>
> -#include <linux/btree.h>
>  #include <asm/cacheflush.h>
>  #include <media/videobuf2-vmalloc.h>
>  
> @@ -111,7 +110,11 @@ struct vchiq_mmal_instance;
>  /* normal message context */
>  struct mmal_msg_context {
>  	struct vchiq_mmal_instance *instance;
> -	u32 handle;
> +
> +	/* Index in the context_map idr so that we can find the
> +	 * mmal_msg_context again when servicing the VCHI reply.
> +	 */
> +	int handle;
>  
>  	union {
>  		struct {
> @@ -149,13 +152,6 @@ struct mmal_msg_context {
>  
>  };
>  
> -struct vchiq_mmal_context_map {
> -	/* ensure serialized access to the btree(contention should be low) */
> -	struct mutex lock;
> -	struct btree_head32 btree_head;
> -	u32 last_handle;
> -};
> -
>  struct vchiq_mmal_instance {
>  	VCHI_SERVICE_HANDLE_T handle;
>  
> @@ -165,92 +161,19 @@ struct vchiq_mmal_instance {
>  	/* vmalloc page to receive scratch bulk xfers into */
>  	void *bulk_scratch;
>  
> -	/* mapping table between context handles and mmal_msg_contexts */
> -	struct vchiq_mmal_context_map context_map;
> +	struct idr context_map;
> +	spinlock_t context_map_lock;
>  
>  	/* component to use next */
>  	int component_idx;
>  	struct vchiq_mmal_component component[VCHIQ_MMAL_MAX_COMPONENTS];
>  };
>  
> -static int __must_check
> -mmal_context_map_init(struct vchiq_mmal_context_map *context_map)
> -{
> -	mutex_init(&context_map->lock);
> -	context_map->last_handle = 0;
> -	return btree_init32(&context_map->btree_head);
> -}
> -
> -static void mmal_context_map_destroy(struct vchiq_mmal_context_map *context_map)
> -{
> -	mutex_lock(&context_map->lock);
> -	btree_destroy32(&context_map->btree_head);
> -	mutex_unlock(&context_map->lock);
> -}
> -
> -static u32
> -mmal_context_map_create_handle(struct vchiq_mmal_context_map *context_map,
> -			       struct mmal_msg_context *msg_context,
> -			       gfp_t gfp)
> -{
> -	u32 handle;
> -
> -	mutex_lock(&context_map->lock);
> -
> -	while (1) {
> -		/* just use a simple count for handles, but do not use 0 */
> -		context_map->last_handle++;
> -		if (!context_map->last_handle)
> -			context_map->last_handle++;
> -
> -		handle = context_map->last_handle;
> -
> -		/* check if the handle is already in use */
> -		if (!btree_lookup32(&context_map->btree_head, handle))
> -			break;
> -	}
> -
> -	if (btree_insert32(&context_map->btree_head, handle,
> -			   msg_context, gfp)) {
> -		/* probably out of memory */
> -		mutex_unlock(&context_map->lock);
> -		return 0;
> -	}
> -
> -	mutex_unlock(&context_map->lock);
> -	return handle;
> -}
> -
> -static struct mmal_msg_context *
> -mmal_context_map_lookup_handle(struct vchiq_mmal_context_map *context_map,
> -			       u32 handle)
> -{
> -	struct mmal_msg_context *msg_context;
> -
> -	if (!handle)
> -		return NULL;
> -
> -	mutex_lock(&context_map->lock);
> -
> -	msg_context = btree_lookup32(&context_map->btree_head, handle);
> -
> -	mutex_unlock(&context_map->lock);
> -	return msg_context;
> -}
> -
> -static void
> -mmal_context_map_destroy_handle(struct vchiq_mmal_context_map *context_map,
> -				u32 handle)
> -{
> -	mutex_lock(&context_map->lock);
> -	btree_remove32(&context_map->btree_head, handle);
> -	mutex_unlock(&context_map->lock);
> -}
> -
>  static struct mmal_msg_context *
>  get_msg_context(struct vchiq_mmal_instance *instance)
>  {
>  	struct mmal_msg_context *msg_context;
> +	int handle;
>  
>  	/* todo: should this be allocated from a pool to avoid kzalloc */
>  	msg_context = kzalloc(sizeof(*msg_context), GFP_KERNEL);
> @@ -258,32 +181,40 @@ get_msg_context(struct vchiq_mmal_instance *instance)
>  	if (!msg_context)
>  		return ERR_PTR(-ENOMEM);
>  
> -	msg_context->instance = instance;
> -	msg_context->handle =
> -		mmal_context_map_create_handle(&instance->context_map,
> -					       msg_context,
> -					       GFP_KERNEL);
> +	/* Create an ID that will be passed along with our message so
> +	 * that when we service the VCHI reply, we can look up what
> +	 * message is being replied to.
> +	 */
> +	spin_lock(&instance->context_map_lock);
> +	handle = idr_alloc(&instance->context_map, msg_context,
> +			   0, 0, GFP_KERNEL);
> +	spin_unlock(&instance->context_map_lock);
>  
> -	if (!msg_context->handle) {
> +	if (msg_context->handle < 0) {

handle < 0 ?

>  		kfree(msg_context);
> -		return ERR_PTR(-ENOMEM);
> +		return ERR_PTR(handle);
>  	}
>  
> +	msg_context->instance = instance;
> +	msg_context->handle = handle;
> +
>  	return msg_context;
>  }
>  

Regards
Stefan
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
