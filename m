Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753258AbeA3P4P (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 10:56:15 -0500
Received: from mail-by2nam03on0104.outbound.protection.outlook.com ([104.47.42.104]:61360
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752015AbeA3P4N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 10:56:13 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zi.yan@cs.rutgers.edu;
Message-ID: <5A70959C.9000004@cs.rutgers.edu>
Date: Tue, 30 Jan 2018 10:56:12 -0500
From: Zi Yan <zi.yan@cs.rutgers.edu>
User-Agent: Postbox 5.0.22 (Windows/20171208)
MIME-Version: 1.0
To: Hugh Dickins <hughd@google.com>
CC: Zi Yan <zi.yan@sent.com>, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] Lock mmap_sem when calling migrate_pages() in do_move_pages_to_node()
References: <20180130030011.4310-1-zi.yan@sent.com> <alpine.LSU.2.11.1801291943330.2657@eggly.anvils>
In-Reply-To: <alpine.LSU.2.11.1801291943330.2657@eggly.anvils>
X-Enigmail-Version: 1.2.3
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig4359BF07744F88F21F46F7E6"
X-Originating-IP: [128.6.37.32]
X-ClientProxiedBy: DM5PR12CA0016.namprd12.prod.outlook.com (10.172.32.154) To
 DM5PR14MB1658.namprd14.prod.outlook.com (10.171.156.16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f3e91b2-3176-4241-049e-08d567f9fbca
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR14MB1658;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR14MB1658;3:kfVJvnbSI2buQVqjp1hvov7D2WMkq8NH9A5h1CBVH/HlN4Va48hgfIG3vRdTIXITP2jfq++8LMV+TJQgocDpOrgD2yL96Ex3nzNbG5KW4wMDxJTTOEYX6mTeKxdCEDVcdixgBVK0ePQgq2+RX7ar9bm/Qk5xrKI3I8apJXkWWtznqwoeAhHpru3z4VPUGe4DiPWHC6g0SowOIw9VOc2EL5x4fO7EixTqwTnHu3/I7cpf5/sCWC+ZtDhUJh/nlBXt;25:8dCr9QULo/rH/sKHLCj6SQomy4DTUpMg+nQh8saPEw0qCzJCipUAc+7GWLabpkf6C49dmeM8rOuk943p1NOOATLHy4f59shc51DiEZ5MNhsJGToIg1lE4H5D85gpgx8EwIyaa4ncl6r/X/GMo4OtQL8SVq2gK/heacJHcWAwCdPkLO7I5sPZO2+QK76YODqzPy4iXHOw1sNXotmz9rJZtP+rtcD3l5PWqXOkz0x+cg7/XVedLdWKsPj4XnpVUhTm4QgAV8DczaAboZ8DK1NL8wtyaR2OuTFT/t0HIrPy7kaU9nAAcQG175Dx5ZOuDrY1gJTrNTTYDFWnRx7lAbOSHw==;31:BR98BQ80MFeYnMQJW7VS7tFyfUUkkAeuuJZZN4QehiexpZlHluCBdnbxG5arkiXnXycQC2V3czMt/2c9+Y+MDugrjr1jpPPhyRANRW9jPgK/QKkfU3MFrE/H2PE+zkZ0bwa50jHKYwDYZ2NS2FziGTPPpsqNE13wY4a9EUH3YQoEWzR1tVlBAqo+yu5NuV2e6utmW3+I4tPY/2XKj99EwXpqWpC2o7L8iHt8DidolQE=
X-MS-TrafficTypeDiagnostic: DM5PR14MB1658:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR14MB1658;20:jOnWm2+cl5qep36gSIgDPrtCByJk1HXMbUULlo2qRRh+OQI7MkvkQmRcQ2c1i9mSpedWEDiL7Km1n4f+oz5zGOreNnxjg6mNssOOC7RQTaIGXGmsq+km2B05g1nqTDdsgxxTYApufgLLwllPDfqIlZ4wx8bVVjwhAganbn164598zk/2mRAvh2GRYyvT8Lvso8RpKsyl4m+fB82nHdbWiVnZBhdfXa3yTBK/AhhK3nX0JcnqtBF3TV6ReBQ648pEfgAInm9rmHtzFw8VA9B/98k7ac9gTXqiOVhyUz5wE91UI/IF6O5Z4azW+U8HazlkWZQhrLNyaffp6Iz9s6HKPy0wHDxoagdNFRram0TGcjRZ1g3q9yKYy/pKXL5ApUQ7+8HwS6Jyuq+7p4Pttc5Tg4bIviCG4lSIPbgxsj+dH8qmmkEfITpKn4FIUAOjaOAQZ/55b9w18rU6FScBQlh9/DFFL1A9sg4asG+FUaTkcH78GO45wmwX57r+IgqlFBnq;4:RQg6cVRd4hNbaEcPRMcR9o7tn9077JLQ6FqNFe7ffd0N9Ie14OFvyTyVtHeaWPdOBEykqK3YhlL4L6QGFogDZi6JpiggGi7B1BjxmV6+LXI2h/4YUWjgCbE8WU1VXJW4AOIZHL/llw3K5Di7uMhxbLnpNqHmUztg2lh7GGLY4t0+PUSQeNeNRX1LCcbO7M7wTdeAR7W7EgsaUEK2agQ46tKiXJb1Y/xa/IBehbwlfA6idwFILiCDabRGghAL7umrYb6jvJ0HpbqC6ayRz2vVmETYOd+w7nIk4nEKDUSlfsfecyokF+pBeYvnwm8xrm4Y
X-Microsoft-Antispam-PRVS: <DM5PR14MB16583DC9CDC4545F447EDBBCA5E40@DM5PR14MB1658.namprd14.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(58145275503218);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231101)(11241501184)(944501161)(6041288)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR14MB1658;BCL:0;PCL:0;RULEID:;SRVR:DM5PR14MB1658;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(346002)(396003)(39860400002)(366004)(189003)(199004)(2906002)(316002)(6486002)(83506002)(59450400001)(26005)(76176011)(6916009)(25786009)(33964004)(68736007)(52116002)(5660300001)(6116002)(97736004)(7736002)(80316001)(568964002)(305945005)(87266011)(386003)(21480400003)(4326008)(84326002)(16526019)(966005)(478600001)(42882006)(77096007)(65816011)(6246003)(186003)(3846002)(86362001)(81166006)(66066001)(8676002)(81156014)(229853002)(8936002)(106356001)(2950100002)(59896002)(6306002)(575784001)(53936002)(88552002)(90366009)(786003)(8656006)(75432002)(54906003)(58126008)(16576012)(16586007)(5890100001)(105586002)(33656002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR14MB1658;H:[172.27.16.45];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjE0TUIxNjU4OzIzOjByMzlEdWtBTkdQTW52TW9kWlFjaFlVVjlq?=
 =?utf-8?B?Y1hTeDhCWlphU0U1MU02dkJXWWN4dWUzWXExcFlHQkdBYWlBQlhFNjU5c2lV?=
 =?utf-8?B?QWRJbTFScW5BdFEvQUxaZWIxZkczQkVWbXROZUZORkIyVHVXK2JjVGEwNEM5?=
 =?utf-8?B?WG5tMFZnT1duYVQ3cTJMZGxBK2M0bTVCMmt1d0tzY2FtS1k3VitrWjhiL2JS?=
 =?utf-8?B?enFhT29TRWx4V1NFSk05UTJBUGc0Y2hyQzI4WjFWTVE2alhQYVpqN1FHaFZN?=
 =?utf-8?B?djNpcnlhSERZZm85OG03WGlqSHZWRDQvenFITXAvL0tuaFJDYnAza1NQcmR0?=
 =?utf-8?B?Y2ZWNHZpc1dWSFUvcGFEYk5SZjhxdHFNVFAvb3NENDB0S2d3RnBDZ1owaXF5?=
 =?utf-8?B?WnZrK1JDL29vVGlOdCtEaUIxWDYyYm5qREFYUWhhUm05TzliSnZCeEtlRHVh?=
 =?utf-8?B?SWVYM3NGQ1JNS1FQc0k1VlhnQmFSaE5Na1E2RDJyZ1JCT2pCQ0QvUUU1SVo3?=
 =?utf-8?B?Rm84M2dSVkZWREg0bmlYV3RjQmFkM3ZTMFlMamthY1FST0x1UUtJWE1rZXoz?=
 =?utf-8?B?M3RjTm5DRjlzQzAzckVxaFAvZGxYVU9UZ0lsZFFYNjNkV1pwWlVKOTBxY0tq?=
 =?utf-8?B?bUVqVjlQbmt6VXRqQlh4TVg1aGpBdGxFZUR0WWtTZ2Z3VGNkV2k5SEdDSjJu?=
 =?utf-8?B?dVB6cGY0bkJtTG15cFBFeS9jY3YxMTJQUkpBNjNMSzVVSm0rN2VYYlFmZ1Vh?=
 =?utf-8?B?TXZ5NFVpYTJsbEdNQi93UHBhQ1ZxMm9JdWZrVkZsTnZjUFNtOVZsdzMya1pv?=
 =?utf-8?B?dm5BbGJmMUFtUnp5dHA5NTA3MWdTelY4NklHV2o2YTMxMTUwYU55by9PQjZm?=
 =?utf-8?B?VEowVE10WnltdlJBYXBJTzgrdVk2cWVSR2lJNEtLRkx2OE5XSUtoQ3VMamp4?=
 =?utf-8?B?RzZRVSt5bU9uZVlMNUhWelpOR2ZoSFhkTGVsZDJLdXYxNVBzdEpsY2xIb2wz?=
 =?utf-8?B?aE05R0w0bTR1TE45NUVQQnZxalNWaDE0RmwvOFo5TnE1Wi9ia045WHR1UU45?=
 =?utf-8?B?cHVCeU5KcjA2STl4eXhudVVOeC9tTEFEU1Q1SEdWNWlWa2VTdWdvUXIrVVc1?=
 =?utf-8?B?a0dia056UTlRLzJaNjJOdHFjZjdBd2k0Vm5QRFFVQVd6T2xKYWhLR1NoL2o2?=
 =?utf-8?B?Rk8vY2NDQ29EL1hXVVBPb0s0cFFZWjJFZm1ib1JUd0xJbWNIcGowMTRHMjIv?=
 =?utf-8?B?U0RIZ0dxNmhlR2FCTm9XUm9GVy95czdsOGtSZy9OaDZkd25VVld0eWdTZEkz?=
 =?utf-8?B?cmdiZkFpY1BjSWxRVU9jL0lQVWtxeUZHemZTNE9WZ1ZhaHMrbEpBaTdVYS96?=
 =?utf-8?B?dmxFOWpKL3NQU0lxbGlGMDVtU0tJZHFydHNzYjRmdGpIWkVRclA2OFdDeitR?=
 =?utf-8?B?S2pHZWd3eWZJRzRzd0txR1dzdmg4TzlLTnFjcVZiM3lzejRsb0tVM01wRjRu?=
 =?utf-8?B?NkxnL09PNkwrYkhuYXVhUS8zUzl4T1VlWTRnaGRFZDM4eWxQWmdNUXlxYXdr?=
 =?utf-8?B?RElJQVdGcFZET0hXUURFR0VWaENzekkrYWg3N2lIemU0K2sxWDc1bjByYmxO?=
 =?utf-8?B?SjQ0ZDlsWFlzV1R2d2VSdXp0L3AyTE5nMURxYUtYUk16eFRyR2ZabmJicWt5?=
 =?utf-8?B?a1JzeS80bTVmQnRVYU13Z0F6YU9nVDQxa3RwTmpZS0V6ZXd6NkZGcEdNam1Q?=
 =?utf-8?B?eEhOVmk3dkpjQ1JmUGdwMXE3Nkx5UkF4ZGFsOFcwWWtTemUvdUR1WFRGV0JX?=
 =?utf-8?B?SHRmZWI5SVhjUVRUc3hsZFN6KzhSdGd4VFJJYTRBQUdncTdRR1k4Y2pSY1RQ?=
 =?utf-8?B?WUdvZVRLVk1vV0hudlJtbHdiZnA1WTZ0NFVjQjV1UmJHQ2hOZDZLbE9Cd3Fl?=
 =?utf-8?B?eE8yeVJPZkpuVHpTUWxEUWRLQUhtbk5WL1hRSjNGMEcxQkJ4QWFYdWJsRTZu?=
 =?utf-8?B?OGRIaEtxTVVtb0ppYk5QV25EUDhLTGR6MXdiekN3am5MNjkvdmJPeHN1NUZY?=
 =?utf-8?Q?+2Rs=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR14MB1658;6:ihGW4XyhIDIDprWfQmkSd/0n0S8aZL1+c7jy9ObBasPGus3gP3ln9VczUkCRUSjbYMmtq8l82HQZoNeSBDtmUFvILyAnA+TqUsdWtzkACKlFhWJWruVEpVfBKkT1P02IYDhqlycOD1fDyz41Gx5uFf4jetoZYAATLgMAI9+r6okKimF5Wogwvsar3bYXNQO5wNMRcvFX6GiKyb8anuGdtrNwszbiTEWMUTax1klj846saUubde/RgurMKyoVowl16xi07AZigMSO8kChXG4F8bi+WmGurIHZuEThoSzocMtHE7CWgq2hWInsFveKh5DJCfcfsy6MFKLMdiecemeanqebfe2UE9fxz2wheU9vdL0=;5:0hvHu4Oc8rHkYptwY7S9e8jVc+OBmeePULSSOkSMl14kxFWroSSIkEfalBvqqrz5xdSy6iCO/tVS/+heZbj7ECAM9gG+8gSJP4nlLKNYRbKYWDECgtE0gaD6qkCguLv8faorHtpRR3WXp4180r+ZuSnU0mFQzWphP2vSXJAKnHk=;24:LfdMEvdShHjhroeAozqZwg7clwyM70J06za3k7Eb0xbBN3R8mCRMA5fLu8aUnwP3TOcGFirWYHqZFZ6dlrcT+G+kzzU8tZOy/R3gkTzGFKk=;7:jpPOYan7Y3iVxhWevI7nsSEWgbZ9cdMCoWmf/I8Iu4FMVQGoLwEIn6pbwpknYPbPbNIA5dV3eEfFzjKBkCa9fjVbSd24IRbMFyQ6XvrU+ga4rDNMOVEWyq5P3VBjlanNyyqx7W9kCezrqYp5T1uC1b5gycOEvHONEwlgjLdgR27gWkOZ9LoU16jpnbl8dexhNpsUzJDJDD64xdXOxucywF70aVnaK0SuJNV4pPQIpSwbaJDlgWQR0/41vKjyu01x
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cs.rutgers.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 15:56:10.5068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3e91b2-3176-4241-049e-08d567f9fbca
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR14MB1658
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4359BF07744F88F21F46F7E6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



Hugh Dickins wrote:
> On Mon, 29 Jan 2018, Zi Yan wrote:
>> From: Zi Yan <zi.yan@cs.rutgers.edu>
>>
>> migrate_pages() requires at least down_read(mmap_sem) to protect
>> related page tables and VMAs from changing. Let's do it in
>=20
> Page tables are protected by their locks.  VMAs may change while
> migration is active on them, but does that need locking against?
>=20
>> do_page_moves() for both do_move_pages_to_node() and
>> add_page_for_migration().
>>
>> Also add this lock requirement in the comment of migrate_pages().
>>
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
>=20
> I have not been keeping up with Michal's recent migration changes,
> but migrate_pages() never used to need mmap_sem held (despite being
> called with an mmap_sem held from some of its callsites), and it
> would be a backward step to require that now.
>=20
> There is not even an mm argument to migrate_pages(), so which
> mm->mmap_sem do you think would be required for it?  There may be
> particular cases in which it is required (when the new_page function
> involves the old_page's vma - is that so below?), but in general not.

mmap_sem is held during migrate_pages() in current implementation.
http://elixir.free-electrons.com/linux/latest/source/mm/migrate.c#L1576


--=20
Best Regards,
Yan Zi


--------------enig4359BF07744F88F21F46F7E6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJacJWdAAoJEEGLLxGcTqbMgOIH/2PjV4TPU9qC91J1S6jnIM6U
1Vr5heZS3a79kGJ9DtFsAOrZaoDgWYnhn9TXt7y5paQ7tWeGZPfmtHJPZajiZrud
sn3VcV+EjOp+q3DKlmQ51Z55/b/7EgkapN4Sy4Q7+RDKqPUonZVyvuSG1zV0RlUL
1iAoZDu/waZ07qRVdG0aw75/1pCPs7hG9qkkTy/X1US+o5Sxo0/1YFw3V9xw9vHe
NDsif0I8EhkVxxRjGiaODxCzexSD4K5boEjRthOAjvIVP3JKP3qQrhCJ3K5GqLTj
U0RZnWT3vnUG4Xe8SoN+jFNSobZt/seNhJ0atZZla+WNdeUChilG16aVJOEq++s=
=+r0J
-----END PGP SIGNATURE-----

--------------enig4359BF07744F88F21F46F7E6--
