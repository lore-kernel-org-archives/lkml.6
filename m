Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753215AbeA3Pxe (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:53:34 -0500
Received: from mail-cys01nam02on0092.outbound.protection.outlook.com ([104.47.37.92]:45037
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751474AbeA3Pxb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:53:31 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zi.yan@cs.rutgers.edu;
Message-ID: <5A7094DA.4000804@cs.rutgers.edu>
Date: Tue, 30 Jan 2018 10:52:58 -0500
From: Zi Yan <zi.yan@cs.rutgers.edu>
User-Agent: Postbox 5.0.22 (Windows/20171208)
MIME-Version: 1.0
To: Michal Hocko <mhocko@kernel.org>
CC: Zi Yan <zi.yan@sent.com>, Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Lock mmap_sem when calling migrate_pages() in do_move_pages_to_node()
References: <20180130030011.4310-1-zi.yan@sent.com> <20180130081415.GO21609@dhcp22.suse.cz>
In-Reply-To: <20180130081415.GO21609@dhcp22.suse.cz>
X-Enigmail-Version: 1.2.3
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig7AA550367DB032CD46EA031F"
X-Originating-IP: [128.6.37.32]
X-ClientProxiedBy: DM5PR12CA0004.namprd12.prod.outlook.com (2603:10b6:4:1::14)
 To CY4PR14MB1656.namprd14.prod.outlook.com (2603:10b6:903:15a::18)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb73f6ec-544f-4fcb-5259-08d567f99b7c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:CY4PR14MB1656;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR14MB1656;3:dk7KmyyXF5CtvS0ZeLLWf0XEicXmkLJhEPoKpfcfyWXKShTf9YpFcCTnMdH6l+DeMuQ2TX8x/Dli2qt4K50R6j0pq/uIzQgG53uy2/VpYWnFHGm1zEfrHtoUkzE2l6AObvtcS49NAXYwizUsfy6VUnLBR+vWUirov5mmAdzWKFDq2cqB7v5+Qjuk8s5AOvVI46/GYLPTV4HedGr2SVLDbb4w3GksWnk/6FZ1v5ly0IoEUCscV7lwMuCw/4H9SeBY;25:h0uXRwvsM7saDeRQmEliJrlaUNBAhbTXrXj1CUGhASvALQkw/YQI5trpIO2l8kZOD74QcudQOKVFEnv5QuiCS48+gmutmObs70dpotZrBz40r2Hpy/gutevwN5fnQMAEWU9dTZluUm/wS+3aY49T+3zEL/vBqfj4a3H7P10Nh63A38b78Aaalh3CfmUKWH6SIYrvA5NuVhqvAvPIvsmgEmgCLOVkMPqzQb5AgfSjL9Uj2f1GlGve1Txr4MmPY6bdQ39t9l3JhlgTkcyhOCdaxK5MwhtXXylLTBwLjSMymuamHwIRjm9gz++S9/NPnHXWI+LcKvpuRhSarMjzP9oOog==;31:PVrbM8PjMA7p6q0kN0lDUyScOd4WXrv/SgUCHgVbBXS+DORi0CX3ZZtbXGbFPzVi+IEUBahxUsXWXu+3d9iG6ft5xKk4DPFkdWO0poBx0nb46nJep2caTmstBqQMpLp8LftrO7W2mHgIWBc+GlL0+gJXeO6KcnXTEyrcoi+PX+69+e+s4+gtJVOP30FKC9/9Xa2tRF9iOI/oomH7uA4pDjd4xupF/GBmfQwR8i+6wl0=
X-MS-TrafficTypeDiagnostic: CY4PR14MB1656:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR14MB1656;20:692QBSXp02uVrqr8LflgjP+z50rqpdb0QR68MjnpdW6R80fwHkfUxzDL0N9w0AqzPvg+F6j0PgkGiRqM0TQYdLxulGln4IZVNOdt9Bg06E6ZzdRsvCGgx2GpYHxB0qacUt4WvZxxEPi6JNXmoFGrE3H2mRS95zGb5K0IXImQFZSZKPljq1iSsMWghVagagveoO47f+37IfP9Ehz/hfznIwi7cPXdP16dLPz3bR4kq96VPfFqj11TXOnnP5We+btsgB3ypllwG7Nnk9895oMCWYxhaRyuXmz8s9oQuTPe67hIEpscN5xkMwMTSUAKiJh0in1KJ2KMmXqXYq2Xs+vggAFTHoG1nUqnQ3+RMXIgYTMRM0oNvpxdQ5Zf8MToJ8oCGAYWNdu6QlRbxbQ46qPU7q0VSx5EcTis+kiviFOyYKShp95A2sDHmlQmE5NJM9mIN6CERt92h3SDNAkPkSg2wmTznrcQ9JqS52XuRcjIiNpVXOF9l+ziGbs5HYICH0bS;4:M25rceg+7uvGReAtvzJm0FM5hH4BoB6C3fUk/TR/aKfgPNAUIoaj4n2HJlhOLcIBh16n+fJf3sJ8DWB0EG71gRv8Op+ToUK8UOY6GxJc/ayZXqH0HiV0Xy4KOp4QV83z4iChFtwyAokFeiGkT+EyOiks0LADhOQQa8hKL1RhXFA7VdGcWGFPefQaYsjATm1GEjHSophhY+7kJNoKV/8/ispHJv6bzFn/vKlXLYEuOJZBXETlTxoyAZ9FADBuLVQHtu4OH/rd4d1awjF7bXzN/CZX/Uknenn4/X49t5ZuFC2zU3YEmsAA89HgTsAionDL
X-Microsoft-Antispam-PRVS: <CY4PR14MB1656DDB52B024C9692BBAB9BA5E40@CY4PR14MB1656.namprd14.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(10201501046)(3231101)(11241501184)(944501161)(93006095)(93001095)(3002001)(6041288)(20161123562045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR14MB1656;BCL:0;PCL:0;RULEID:;SRVR:CY4PR14MB1656;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(39860400002)(346002)(376002)(396003)(366004)(189003)(377424004)(199004)(21480400003)(75432002)(97736004)(83506002)(8936002)(229853002)(33656002)(52116002)(25786009)(106356001)(81166006)(4326008)(966005)(8656006)(84326002)(105586002)(81156014)(16576012)(316002)(786003)(58126008)(16586007)(68736007)(54906003)(5890100001)(568964002)(478600001)(76176011)(6306002)(575784001)(2906002)(86362001)(88552002)(53936002)(3846002)(305945005)(386003)(7736002)(16526019)(87266011)(65816011)(33964004)(77096007)(66066001)(186003)(26005)(6486002)(80316001)(8676002)(6116002)(59450400001)(42882006)(5660300001)(6246003)(6916009)(59896002)(2950100002)(6666003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR14MB1656;H:[172.27.16.45];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjE0TUIxNjU2OzIzOkxtTUpsNmo1YUI2SDUwRGlQTEhGUGZTQjh6?=
 =?utf-8?B?aXJKU0YrRHZKOFFycmdiQW5pZUsyV0NtUG1SdjJ1ek5jMkpKN1dYZHBZbEYr?=
 =?utf-8?B?dnBYZk5FcEFmTFdSdWFSNkhDc0JCbS8yZjhHMXNlRGs1a0xWS2tTRXFTVlBK?=
 =?utf-8?B?U09qcGw2bnpMRnExYkoydVpDUTZ4WVJIUmhSUXVibndTaVVQOEh1MFdSaTBN?=
 =?utf-8?B?bitzTXdReXNZTXBRQ3E2cHpYL3p5dVZZait1U1dCQkcva3BENU1ISWEvbjJx?=
 =?utf-8?B?MlhjMUxSSDlCeWJDSDN5V3BmSFZPa2FNVXhXVERNSXo5NWhaeFNnbktvNmtX?=
 =?utf-8?B?RmNSN2Z2L2lHUXJaa1lxZVJCQ2tkYU9kTGlYbUVsVEFnOE5xMHB4NWZuZXBl?=
 =?utf-8?B?bUtWZDZDUG9JbnJsMWlkSkdtQTBGUVlrcnptWXNBNm1UOGEzMi9GWjhWOERU?=
 =?utf-8?B?UWdJSGxWeGNwazFGMFNKZzROVkFTSUZYUFcwN2dSdTdSSFVONE1UbTl2TXBX?=
 =?utf-8?B?OXdZL0toZll6MW1MN1B1b0wwRWQ0VG5uYjZOSjR5Wk9rL1JMMk9Md2NSdTcx?=
 =?utf-8?B?N3ppaWJmbkdSazFKT0Fmdm5LT0N3NDVXazFoTTI0dCtHcUdPMWVMcjJWdUY3?=
 =?utf-8?B?d1ZnVktWZ3VTNzhQYnQ2QzhTaTc4MUh1OEFnUHUvUkFDazBXRGYyYmRSMGFq?=
 =?utf-8?B?UGdmdW5VRVFyYlkzd3Nyd2NsbSthRGs1YSt0NkVVSVR1bU56eUh2dTBRTTND?=
 =?utf-8?B?OHNOTkpKOERQc2JDd0g1SCtBcHhhOGJ0QjFGQ1RlVGJmTmdvcGdOYnZ0amFi?=
 =?utf-8?B?RTJ2eUpHbnIxNUNEY1Q2YklGZm0vTFV6bmlmUnY1UHhLVkVpejBXZGF6alQ0?=
 =?utf-8?B?alNJWUUzeXZySzQxU3ZFeVFrZHFLTEZOL0l5UVdXN3U0ZVQwT1I1Rnk0ckNX?=
 =?utf-8?B?WHRGa0NFSEpLb0pUYm5oTnBjSU9WVFZsTXRtaEdBdHMzbUxPTjRuaG81ejFW?=
 =?utf-8?B?VnBOOEpNeVVsMEZ1eFJsTHZ3L3hkekgrNTlBUlpWdmRRSE50dW9NRm5sOTBN?=
 =?utf-8?B?eVlac0RTSDgxM3Y2Qm5aYld3SHFPQ0tYWFJWMUFuMTE3MWRJU3VkMFExWG9K?=
 =?utf-8?B?NVdJeXphMmFaRHVEdG1vZGhkSjFCd3o0VXIwR0VCVkQrQmpVQUdXbGQ2Wmt4?=
 =?utf-8?B?QXQrOUZGOWR6bTlvZUhLWjdiTlV2Wms0ZFNCZEFiS0pNYnkvOEEvZGtKQmZx?=
 =?utf-8?B?N3p4VHlIRzRTNkZ3VGpVTXZaeThTd0N5ampadHE2ZU5LSzQ3Ty8wSllnSVF4?=
 =?utf-8?B?SFJNS2FOYjN2WnBxb0VoWUJhcjJsZ1NaNURaNmFNQktHb01OQnN3LzUzSUp1?=
 =?utf-8?B?TzZEVi9obmFKZTBzTDJRQzZNdkNKaTlrRExYRG40WG00cHdLSkJCUU1CNUN2?=
 =?utf-8?B?UUlKOXE5elU4N0grVUdDZWRhL3dYUmxFbUtFN3pyVkluUVlPOTh3djd1ZGRv?=
 =?utf-8?B?b21wL3ErWE94YmhPVGdYU2JGTTVGQXNCWENROUllRVpjUTBRZCsrQXRmVGpw?=
 =?utf-8?B?YXhnOEJYTzZhMlcrNkpUVnBWRWhkRXNXcE0vSWlsRVJJei9EL3FjNEU4cXd3?=
 =?utf-8?B?YmhRS0o2M1ZaNXUwYjVxWnRWRkh0V1BsdVNWL3ZmT09qRUhTbUtZN2FaQm96?=
 =?utf-8?B?WU1nTG9TaTJrK3FBY0d0MTVxQVpQK3lRRUxuOEFOZEJFWmZ0d1lXQStHeStI?=
 =?utf-8?B?djZ4MU5CMFRrZk9RQmN1TGdwVmVJNlpWdVV4blBXb2lZRm5XTzUrSFpVR05y?=
 =?utf-8?B?U2c5c2ZxTmpHeWFkVFhpOUhwY0dFWjcyOVVZbWlnK1Bzazg0RDBsVnNkYVVk?=
 =?utf-8?B?dUlkdkhoMU84NE1Bc1ZTWVJ3VlZZNGtoR3BYdW1TU1M1ZWQwUFZkeGcxOFAy?=
 =?utf-8?B?dHIzN3NVZW1Fb0w3THRZY3hJS2tyem5tTUVwSVdXM2xxa0p4TXYvQm9pUUQw?=
 =?utf-8?B?eFBjOWFNeEtZNHZWdjg4VUZaS2hrRTZoOUU4Q3JQaEhaOTd2OWxpNzZsOXVC?=
 =?utf-8?Q?Y087EnHedaAb38tfbR5WhX/gf?=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR14MB1656;6:o+qoDad3p2+eDsX3tunAfc7f1xXypyVntQUFTRQ5DTOrGKLFfy4Qr27wOEwD8A63QwP8VmPxzkCR9tqjvWXN8920TleDNqMKHIRW36mBWrE8QYGK8ASLHLWBmkfxItU8mGSP9pUw9B+3B/fTkwmvI/WR0oY1yfz5G/oM9u2UBK0YD3uL6l2LuGcB7l3oPPiVnSsyJ+m48oRt4ECfHns26BnW3x5LrFkJ6USJ+nq1BE2UUbIvyLaH0SDG4esEeawJgohjK7gVptaN+fKUzF+x5/nIE9cQEdqDap1sh98806z5pGQiSC79ErNNODVerGKxCQWF2offfEfSiiM+BLsf0w5XM2CKq5ObVFNkx2Rk9kg=;5:YuLawJyrLye1TCCoEmF0Zv10rJ4RyO6zzXJePDBuxM8IwmbZpFpybeAA8hAmVZQiq45JAi1uGJGGIFAopya7VrMwppYizKUz1E5STiOzS5akOBFjFKTXaddq0YNQXOecpRnVxOyhLbS4heS/PZNquzfyM7PV+CDEO8YBeaP83Yo=;24:Bi/hq1lBteBdwE023EEt/JCfBJ5Hv56vvvNIAIZJw8+w3T5ZPdPSjU8Qt3+mclPJHO8XPYsa4myse0BuF1Zqgd4xwVtquW5Ij4j5g1W+ip0=;7:awf3oMBmI2hWSmnfdg1nBJmQug31NBrhaVwMGuqT2Jf6ZxJ5OScveVXkOwdq722bRopdfExfndl1yzxdIgVwsCTuG9wrv/gX+YGVnt0K7RzSS3kmMwJAXHlLtddim25mZOfAR5GvuOfnr9aaep3VZxFvUsUTa64HGeR7qGvLrNHWJef1hwknxKM97nirwa+Xmpp4ZHqZQ2VbgjNA/47Hy6R/YyG22DtFb8Za8ZqUAmGrNRmRT0z5L/tqOEfEkjOe
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cs.rutgers.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 15:53:28.4676
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb73f6ec-544f-4fcb-5259-08d567f99b7c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR14MB1656
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7AA550367DB032CD46EA031F
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



Michal Hocko wrote:
> On Mon 29-01-18 22:00:11, Zi Yan wrote:
>> From: Zi Yan <zi.yan@cs.rutgers.edu>
>>
>> migrate_pages() requires at least down_read(mmap_sem) to protect
>> related page tables and VMAs from changing. Let's do it in
>> do_page_moves() for both do_move_pages_to_node() and
>> add_page_for_migration().
>>
>> Also add this lock requirement in the comment of migrate_pages().
>=20
> This doesn't make much sense to me, to be honest. We are holding
> mmap_sem for _read_ so we allow parallel updates like page faults
> or unmaps. Therefore we are isolating pages prior to the migration.
>=20
> The sole purpose of the mmap_sem in add_page_for_migration is to protec=
t
> from vma going away _while_ need it to get the proper page.

Then, I am wondering why we are holding mmap_sem when calling
migrate_pages() in existing code.
http://elixir.free-electrons.com/linux/latest/source/mm/migrate.c#L1576

>=20
> Moving the lock up is just wrong because it allows caller to hold the
> lock for way too long if a lot of pages is migrated. Not only that,
> it is even incorrect because we are doing get_user() (aka page fault)
> and while read lock recursion is OK, we might block and deadlock when
> there is a writer pending. I haven't checked the current implementation=

> of semaphores but I believe we do not allow recursive locking.
>=20

Sorry, I missed that. If mmap_sem is not needed for migrate_pages(),
please ignore this patch.


>> Signed-off-by: Zi Yan <zi.yan@cs.rutgers.edu>
>> ---
>>  mm/migrate.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index 5d0dc7b85f90..52d029953c32 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1354,6 +1354,9 @@ static int unmap_and_move_huge_page(new_page_t g=
et_new_page,
>>   * or free list only if ret !=3D 0.
>>   *
>>   * Returns the number of pages that were not migrated, or an error co=
de.
>> + *
>> + * The caller must hold at least down_read(mmap_sem) for to-be-migrat=
ed pages
>> + * to protect related page tables and VMAs from changing.
>>   */
>>  int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>  		free_page_t put_new_page, unsigned long private,
>> @@ -1457,6 +1460,12 @@ static int store_status(int __user *status, int=
 start, int value, int nr)
>>  	return 0;
>>  }
>> =20
>> +/*
>> + * Migrates the pages from pagelist and put back those not migrated.
>> + *
>> + * The caller must at least hold down_read(mmap_sem), which is requir=
ed
>> + * for migrate_pages()
>> + */
>>  static int do_move_pages_to_node(struct mm_struct *mm,
>>  		struct list_head *pagelist, int node)
>>  {
>> @@ -1487,7 +1496,6 @@ static int add_page_for_migration(struct mm_stru=
ct *mm, unsigned long addr,
>>  	unsigned int follflags;
>>  	int err;
>> =20
>> -	down_read(&mm->mmap_sem);
>>  	err =3D -EFAULT;
>>  	vma =3D find_vma(mm, addr);
>>  	if (!vma || addr < vma->vm_start || !vma_migratable(vma))
>> @@ -1540,7 +1548,6 @@ static int add_page_for_migration(struct mm_stru=
ct *mm, unsigned long addr,
>>  	 */
>>  	put_page(page);
>>  out:
>> -	up_read(&mm->mmap_sem);
>>  	return err;
>>  }
>> =20
>> @@ -1561,6 +1568,7 @@ static int do_pages_move(struct mm_struct *mm, n=
odemask_t task_nodes,
>> =20
>>  	migrate_prep();
>> =20
>> +	down_read(&mm->mmap_sem);
>>  	for (i =3D start =3D 0; i < nr_pages; i++) {
>>  		const void __user *p;
>>  		unsigned long addr;
>> @@ -1628,6 +1636,7 @@ static int do_pages_move(struct mm_struct *mm, n=
odemask_t task_nodes,
>>  	if (!err)
>>  		err =3D err1;
>>  out:
>> +	up_read(&mm->mmap_sem);
>>  	return err;
>>  }
>> =20
>> --=20
>> 2.15.1
>=20

--=20
Best Regards,
Yan Zi


--------------enig7AA550367DB032CD46EA031F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJacJT6AAoJEEGLLxGcTqbMOSMH/RTnT/k9cu8apbbJVImFzYLb
TkeT1eR4ieZCPMoWAXVMmr8xD2hylaPUhExp+wagh0vBfG1uo6bzlZg4kQmXnGn9
/3jxULV+mPgm6nA05H9xr/JQUBK7vnzdZU4jxPwXx7NjaZQuG/JlJsrLecA5mfT4
iTq8HCCq7KLgoeJLDEfVQQXnN8krfZeDiRYfysu/1G2BaNzCGdsbyC8bYmq3eREy
Mz5Gu0ASYE7XHqBKV8+kH61AckLh73lblszN86k+ECIMmQFOAjxokRb1XvJANSvr
KonqjR5OaUx3+yNjYe1ZCHkaentWOyuzlgjezn8v5xZvDWsatMOCedMM0BSnY2w=
=mxsp
-----END PGP SIGNATURE-----

--------------enig7AA550367DB032CD46EA031F--
