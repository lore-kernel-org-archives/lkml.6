Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-1882070-1526355651-2-18409247159786134186
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_MED -2.3, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526355650; b=h8tIY5s7k3E0u28733VZFqr+WAshvK5TGZawW+GlGj+XHNK8AG
    agvZihJljKlAe7f+0G0fAHsP0X35cTkeWrb8QV+BevFni5lVIYgKMmjbw++eSgS3
    lDJCi5mW2qTXkGEtyZ5dJsw27JjAqHrD5Wwy+Iolc0wiUTE+umgk3vMf2yn8p24q
    YBw8O9zrcp5pD6JfFAZ41bJvyk5VMnEeZI7mTzIZGWRrJ+Ey4/rqsCBa3htfCjTn
    83wT+l9yCS8tx9oadtSNPosHigtmdCQIQF9D4/K9oYKQAsRLb2rbEJdAPybOXWaV
    Zr+6ssCI4XJ0MrsWC/HhQmG9bgvClOlaIubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:date:subject:in-reply-to
    :references:message-id:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :sender; s=fm2; t=1526355650; bh=SMR/aW8Ts2hhrf3L8iIoWocmjKDbeoo
    63wwnAfmR1f4=; b=MkFqDCZlzxkCET753l4RYegrw7ftIQ6svQ38Bmq2dqaEKCz
    4QI0FyIVaFTyxyLJrabxrDd/6SW/xTAHs6qeRbXVr6U21EKWmRZaV2foz5XUW6jj
    cz1qsvxo7rgqGw0xTytSVBxjh/u3Fns1GChdpVoArS4nYvYwS8sc4LTQcblKXvns
    uBK6n4VddTq+p4VwyMt4pghNDVBRe3GAKGBBrJK4gtHU3jEQ1iv9U5wQ+LyqPfaG
    QXtrFlfktUHBF+JFNumH1UyaEdL9WK7dw+UK3ZPiZ7w35AE9U4SRA+RC1yIN4HrY
    Q4YWH0FR1HpBmRqVlmD5a7lK2zeTm/jwVjttEEg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
    smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
    smtp_is_org_domain=yes header.domain=suse.com header.result=pass
    header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
    bits=128/128;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org
      smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-cm=discussion score=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass
      smtp_is_org_domain=yes header.domain=suse.com header.result=pass
      header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256
      bits=128/128;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLjaA3jzJlv/kKtbzuWGUQRSEcYZ04BVrNJZMesXlHpRjdGNm0LrjyXUReh+pLvSg5+8auMxWRZPgTcRQODWsmeYDyiPQxLQLksWzNDkiFgK8U2/eQ7U
    KSNM7G6T7V2+MeYidjttLY8oXoZftsaqac2jVL04piTGUw6VcUQn/490LVGfyO1d8aYxgGbxMsrHMrvbpxTwgY0UMgR0gtVMLIVEQbz74Xrlg5CBOgecT9ju
    Wmv/BUdO0cpqXHV+hKpArg==
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=584k1XxxM9pnnVd4MmWcNA==:117
    a=584k1XxxM9pnnVd4MmWcNA==:17 a=1oJP67jkp3AA:10 a=VUJBJC2UJ8kA:10
    a=-uNXE31MpBQA:10 a=jJxKW8Ag-pUA:10 a=ZZnuYtJkoWoA:10 a=QyXUC8HyAAAA:8
    a=ySfo2T4IAAAA:8 a=JfrnYn6hAAAA:8 a=iox4zFpeAAAA:8 a=9Ia1GTrlH08SB9S_7dUA:9
    a=GxmLokfJCzQdDCP0zc8A:9 a=ONNS8QRKHyMA:10 a=DDOyTI_5AAAA:8
    a=w27ZC7bHMYj9Vt11HkIA:9 a=CjuIK1q_8ugA:10 a=pC-h2on8RWMA:10
    a=ZUkhVnNHqyo2at-WnAgH:22 a=1CNFftbPRP8L7MoqJWF3:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=_BcfOz0m4U4ohdxiHPKc:22 cc=dsc
X-ME-CMScore: 0
X-ME-CMCategory: discussion
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: NeilBrown <neilb@suse.com>
To: James Simmons <jsimmons@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
 Andreas Dilger <andreas.dilger@intel.com>, Oleg Drokin <oleg.drokin@intel.com>
Date: Tue, 15 May 2018 13:40:27 +1000
Subject: Re: [PATCH v2] staging: lustre: obdclass: change object lookup to no
 wait mode
In-Reply-To: <1526350548-4402-1-git-send-email-jsimmons@infradead.org>
References: <1526350548-4402-1-git-send-email-jsimmons@infradead.org>
Message-ID: <87bmdh7fis.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
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
Cc: Lai Siyao <lai.siyao@intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Content-Type: multipart/mixed; boundary="===============6995220866358399517=="
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

--===============6995220866358399517==
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, May 14 2018, James Simmons wrote:

> From: Lai Siyao <lai.siyao@intel.com>
>
> Currently we set LU_OBJECT_HEARD_BANSHEE on object when we want
> to remove object from cache, but this may lead to deadlock, because
> when other process lookup such object, it needs to wait for this
> object until release (done at last refcount put), while that process
> maybe already hold an LDLM lock.
>
> Now that current code can handle dying object correctly, we can just
> return such object in lookup, thus the above deadlock can be avoided.
>
> Signed-off-by: Lai Siyao <lai.siyao@intel.com>
> Intel-bug-id: https://jira.hpdd.intel.com/browse/LU-9049
> Reviewed-on: https://review.whamcloud.com/26965
> Reviewed-by: Alex Zhuravlev <alexey.zhuravlev@intel.com>
> Tested-by: Cliff White <cliff.white@intel.com>
> Reviewed-by: Fan Yong <fan.yong@intel.com>
> Reviewed-by: Oleg Drokin <oleg.drokin@intel.com>
> Signed-off-by: James Simmons <jsimmons@infradead.org>

Reviewed-by: NeilBrown <neilb@suse.com>

Thanks :-)

NeilBrown

> ---
> Changelog:
>
> v1) Initial patch that didn't apply to staging-testing branch
> v2) Rebased after Neil's patches landed. Remove unlikely() test
>     as requested by Dan Carpenter
>
>  drivers/staging/lustre/lustre/obdclass/lu_object.c | 39 +++++-----------=
------
>  1 file changed, 9 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/staging/lustre/lustre/obdclass/lu_object.c b/drivers=
/staging/lustre/lustre/obdclass/lu_object.c
> index f14e350..e0abd4f 100644
> --- a/drivers/staging/lustre/lustre/obdclass/lu_object.c
> +++ b/drivers/staging/lustre/lustre/obdclass/lu_object.c
> @@ -593,15 +593,10 @@ static struct lu_object *htable_lookup(struct lu_si=
te *s,
>  				       const struct lu_fid *f,
>  				       __u64 *version)
>  {
> -	struct cfs_hash		*hs =3D s->ls_obj_hash;
>  	struct lu_site_bkt_data *bkt;
>  	struct lu_object_header *h;
>  	struct hlist_node	*hnode;
> -	__u64 ver;
> -	wait_queue_entry_t waiter;
> -
> -retry:
> -	ver =3D cfs_hash_bd_version_get(bd);
> +	u64 ver =3D cfs_hash_bd_version_get(bd);
>=20=20
>  	if (*version =3D=3D ver)
>  		return ERR_PTR(-ENOENT);
> @@ -618,31 +613,13 @@ static struct lu_object *htable_lookup(struct lu_si=
te *s,
>  	}
>=20=20
>  	h =3D container_of(hnode, struct lu_object_header, loh_hash);
> -	if (likely(!lu_object_is_dying(h))) {
> -		cfs_hash_get(s->ls_obj_hash, hnode);
> -		lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_HIT);
> -		if (!list_empty(&h->loh_lru)) {
> -			list_del_init(&h->loh_lru);
> -			percpu_counter_dec(&s->ls_lru_len_counter);
> -		}
> -		return lu_object_top(h);
> +	cfs_hash_get(s->ls_obj_hash, hnode);
> +	lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_HIT);
> +	if (!list_empty(&h->loh_lru)) {
> +		list_del_init(&h->loh_lru);
> +		percpu_counter_dec(&s->ls_lru_len_counter);
>  	}
> -
> -	/*
> -	 * Lookup found an object being destroyed this object cannot be
> -	 * returned (to assure that references to dying objects are eventually
> -	 * drained), and moreover, lookup has to wait until object is freed.
> -	 */
> -
> -	init_waitqueue_entry(&waiter, current);
> -	add_wait_queue(&bkt->lsb_marche_funebre, &waiter);
> -	set_current_state(TASK_UNINTERRUPTIBLE);
> -	lprocfs_counter_incr(s->ls_stats, LU_SS_CACHE_DEATH_RACE);
> -	cfs_hash_bd_unlock(hs, bd, 1);
> -	schedule();
> -	remove_wait_queue(&bkt->lsb_marche_funebre, &waiter);
> -	cfs_hash_bd_lock(hs, bd, 1);
> -	goto retry;
> +	return lu_object_top(h);
>  }
>=20=20
>  /**
> @@ -683,6 +660,8 @@ static void lu_object_limit(const struct lu_env *env,=
 struct lu_device *dev)
>  }
>=20=20
>  /**
> + * Core logic of lu_object_find*() functions.
> + *
>   * Much like lu_object_find(), but top level device of object is specifi=
cally
>   * \a dev rather than top level device of the site. This interface allows
>   * objects of different "stacking" to be created within the same site.
> --=20
> 1.8.3.1

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlr6VqwACgkQOeye3VZi
gbnLHQ//XwpQhuYbubF114KewUnGrMBgj+tX384BqfXbxS/3ddyj41xQtuDOy7Bd
CllvqRhTcJZKRWYCy9vunBNVNJJ/dzXpG0zqeKRf3GK7VrJbMreX4Q+AvOqOfiVz
jGpKLJ5prrAKr2FJyMZZrXOrjyI2GQ36kOVjwa01O+UoEdyIXFpRURsFj2I85nrd
unTbYL2rEvN0Tx8gqIaQd43APOEFfPHWBg1atifgPXrSN2AoEe30Qq2FwJ7DvanS
bM7GFT0Ch63oQ2b+Cmuhj5i6+Evx5O6IOcW2RzJ3orFIS+P6E/Cm+JsIOmRsWUw4
eQKvjR8sYq+DpaOuGb5kaWKTfI+m/W8Jk4hHDwDxfTYcQUxZOxST3HWmGodVKNBf
YdTkl/cv0pedAM4QZRanH6PAhpp6V5su4fyQANYM1lAtpZfHb45/ehfnNIw8r8t5
nmmtZ6m3Cd+01rh2PmwdiF8dyt6T/98kcCoKX40yY4G/gfs1NmWebUotfAkRwOYZ
yCkFieh/OG+M9pGD1f7kfd8VXfoUOlPstAoCtPDKoepw4c5igze06fZa5/Uyilo2
DykPGZ5tsXHxhr5cyLvb7JMZDCBSOgdici5uO+loRyZgGEdSwg83lx/t37z8dOxz
vItkxPZC7kNITUvA0ZyeMRQiOfNtfWXn7x8D7wJAWGRDuXpH5a0=
=9IzA
-----END PGP SIGNATURE-----
--=-=-=--

--===============6995220866358399517==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel

--===============6995220866358399517==--
