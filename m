Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755995AbeCVO3N (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:29:13 -0400
Received: from mail-db5eur01on0071.outbound.protection.outlook.com ([104.47.2.71]:43840
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755890AbeCVO3K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:29:10 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com;
Date: Thu, 22 Mar 2018 16:29:00 +0200
From: Leon Romanovsky <leonro@mellanox.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+3b4acab09b6463472d0a@syzkaller.appspotmail.com>,
        danielj@mellanox.com, dledford@redhat.com,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Johannes Berg <johannes.berg@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-rdma@vger.kernel.org,
        monis@mellanox.com, Paolo Abeni <pabeni@redhat.com>,
        parav@mellanox.com, Roland Dreier <roland@purestorage.com>,
        syzkaller-bugs@googlegroups.com, yuval.shaia@oracle.com
Subject: Re: WARNING: ODEBUG bug in process_one_req
Message-ID: <20180322142900.GD19440@mtr-leonro.local>
References: <94eb2c0bc3aa8b2432056623c735@google.com>
 <20180322124823.GB19440@mtr-leonro.local>
 <CACT4Y+Ya8iMgV=7YGgsO2XnusF9tnGcHHPF5U5oNjQz_eJ+vMw@mail.gmail.com>
 <20180322132031.GC19440@mtr-leonro.local>
 <CACT4Y+a2KB6vvgFcqkq7cMCiCZQEFNxsCTgP+_gtgju8H2q9hQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HtrkgkD3uBADSQLK"
Content-Disposition: inline
In-Reply-To: <CACT4Y+a2KB6vvgFcqkq7cMCiCZQEFNxsCTgP+_gtgju8H2q9hQ@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: LO2P265CA0154.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::22) To VI1PR0502MB3918.eurprd05.prod.outlook.com
 (2603:10a6:803:f::25)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1ca1cc19-1f87-461b-16a3-08d59001445b
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:VI1PR0502MB3918;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3918;3:Ok7r7iEr2/QQ4VKxL2iglO3v6ptKsPsJyzrsAIPfIKfDXE9IGLo0uKmCEJkduKfn4NCByXzQatev4kzR7BpLD6fi35prfOtRThuTTY08q83Qd/WIQPw3DEFN4DIlJFNfhH9InjFI1soyGBAl9xjUKkrL1DpiPHvQib6QBjsCIgfdlsmynAMykOhjrAituyxqI58KOTFYKNMP0+JEIFL3K1+hY42c8o0Y4D6f0AXWJ849R85EjVjj6RBYQIK2otWp;25:/dI6N53/PTsKjGFC9fln/9xAd3MnUgHWub1Nj/sMI0m4WZ5xjR/ZFOcTUgRORaoBHilJeHVQI0aTvkcj8XHh9O9SRpYTaCSox/UqKZXNb7ZjfUduYiYajHcnYYIJWr6My/3MAP9VOukNgeZ+N1iu0uTEAq/ZSWPmRCYOm2IptXglZ798ePwWVDYGJp4OAtp9viVWXVS/gKkCNuC7xToe/kN5MI6u2oGcCXBRRmCWQjjgKeF0cUlQECjSgeoDP+FfOORWISwezxJxs+oFh78gWSq1Qt++0jZBHH1oah75sCV/O3WybfXuKLU9HmTLvop6ue4rIfcfEkN/V4I3uN0GpQ==;31:mUWV0GI+MFd0tMQa2CHBc2rhph4L0q+xaZfx18BT7qw6OYSVJOCFPEaglr9d+OmZ0fhU7UA5eTh5X4NeNWqa/PWdCIiePyYAQcvFQ6qrlK+cysCUvsl89231eL9+ubQVLZ7IVyMcfkAtAQeoaoaoOWwiFxzGuZEnBUfMTojDFqrYDiD1cbLWltGmxpfrHtXNNYgLMZ7qVI3PhLt8hCoviF4Qx8QAj67XXARrddIJA5E=
X-MS-TrafficTypeDiagnostic: VI1PR0502MB3918:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3918;20:tT6cnU06l8z55lgs7Ir/oTbDeI2012MY3Cgbbbgwjb9XS9Jd5DrNoWQnMByxBxTm/Kwa91zJPaA7bvpvShQyM+m4eh1ZV4lZweQGslByafQbBW7d21JvW4QUBNFWj1fz1TqTOeejdfsp2/lJWsZc6yYeAKBlDCbPKlS7lyo1CGGyNXost5ZN1pRNq6tEit51wK9WJW78p+PnTbERBM5qGQKshqbzj/ESgG8qKNsg8qtue68TgIF/JCGmXBBEvg0d+6EBDbPk36+54gNnKZSCilp7oeJurXdNFCkvMHoGKRm9J1EzHVocp9EH6JJRxU12IEUdjsN36o2ALpJkJKJ/CXeKt+TixY6wx97nvjKRyM7Cwp0uZCMQoQhhrHoa+Y0HXrUplBdOZrf2X1UFiKmtmHzxqNzun05XhVebgz///tr2p64BaFlNBX/Ddy2uMUWU2x0Z4IPNomXLKTyqvJWRO5RX2yazSe0yuPWxdg/bpznAwh9mYLj1uljs+C262AcN;4:Om96KLcvoAfePsjSkQx1GIYz31IfKn1VJSfYbjcYmgdq+OfRhIMGFi5/bw7ufow25ws/jVXVLxOycG4+FyGAvUh82u0tOJ2mdLLUfQ2XZbcT4CJ1f8CXPNOA4MtLiX1lvkOt/C0YN6kIQH1hmZ4r9qpJJQj73wd7y5wRtHQgGdT9so25n8oni19NTeze5AxvQJIUSwbbNhQcAxWl3BSR3KYehUBA8CKS+3djB1FyXJKL33BxOgnCd+miRo/lhYeDCQ4Qv6u9lnT5w3aOK9x8Ow==
X-Microsoft-Antispam-PRVS: <VI1PR0502MB3918B0D2F5EEA29FDA5E33D4B0A90@VI1PR0502MB3918.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:VI1PR0502MB3918;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0502MB3918;
X-Forefront-PRVS: 0619D53754
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(366004)(39860400002)(396003)(376002)(346002)(39380400002)(51914003)(45074003)(189003)(199004)(53936002)(6666003)(84326002)(6306002)(6916009)(2950100002)(305945005)(7736002)(106356001)(9686003)(63394003)(25786009)(316002)(52116002)(6496006)(93886005)(58126008)(68736007)(21480400003)(16526019)(16586007)(105586002)(86362001)(54906003)(98436002)(386003)(97736004)(2906002)(478600001)(81166006)(5660300001)(44144004)(3846002)(4326008)(7416002)(6246003)(6116002)(6486002)(76176011)(81156014)(33896004)(76506005)(966005)(1076002)(53546011)(229853002)(66066001)(8936002)(26005)(186003)(33656002)(8676002)(446003)(18370500001)(99710200001)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3918;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;VI1PR0502MB3918;23:bnoH1u1rVAeNS+ybGQ1QNL2m3RlMTbuFwQUBr77?=
 =?us-ascii?Q?IppR2uMyYIvxovwl6BhKo9NCL5WxhkWruCMO7zCtWnlbt/7jjbPRgTgDE/IU?=
 =?us-ascii?Q?P8csC7JywBIxaKnJjxacHDnRM3PXDXK9UNEN777tmhmkGo95mkMQcD/U78sn?=
 =?us-ascii?Q?vAxACQX1+vIyCvQJfc/ZM2f+eM/M0iTV885gcOsMHd34AsVePG4kD2bE6siP?=
 =?us-ascii?Q?extsRSvJVoUP9KNdhU4NbxbJY5Oxcg7qoLROsCDT3F9B9JVKRLun+3mv+qz6?=
 =?us-ascii?Q?+W2162zocncUGfJx/i8+u/bkenrjVLXef+spiu57XF1SWbFUh3zQTcLN6qKV?=
 =?us-ascii?Q?c5DQlEkSv2IlRbnVrpEgTHFLeLWAxNj2hrettobaxcZhZm00kpXoubdS4MBz?=
 =?us-ascii?Q?dbUIwQTQtPTBAZOrXZcoGrcKSA9cs/CGnR9xFLa7HBYMqtx025XeihL7mCLg?=
 =?us-ascii?Q?ocSdfdRWZRTcRnlVIsyivmtK6Nqy8kGnJyJ8rD2wItrzOLlmXYwgkNREChDQ?=
 =?us-ascii?Q?7bvo7ibtwmPOF0KqiooodWwbtHMDSxDW0AJpdHhJua5xZADLmwybOU+cd5gO?=
 =?us-ascii?Q?qeCgJkqzHSHI/RgX7OEw8KqO99H+T/frim22IPAd2lUwdxDVZYB65zaYj7Hj?=
 =?us-ascii?Q?0/lZwOJMk4lgi9GRAlojSy7O55p+6PA8s00tu5HWgxIl9XZtZm+QwfWbMhS1?=
 =?us-ascii?Q?ilNLMi9zGB5/+9UqM6ACTba9u+SBhM2RqX+wFFpKiIMjZoefI6u+5KInjVd8?=
 =?us-ascii?Q?QBkL33jmCPDMlN2c94P90VmkGKO07bL9FQrenFVy5c1sLev66gVwPhv8f06j?=
 =?us-ascii?Q?3P7bbLJ/99sh76QfrHT5zod38eZB7oxk63RQDJY1bU42pKO6eEc2vUENMv1r?=
 =?us-ascii?Q?Yg5vmDG8BYIBvxPUWebcQAMFynWib9NjvkkliXnzUmS7GFDnBgHbAlUV6sY7?=
 =?us-ascii?Q?fZlWu2BCWm7/qc6ndOm2JhZOZLQ4iuwuL21yk/JPQxdjP3Z9s/1VMHWO1s9q?=
 =?us-ascii?Q?1cbIxiSl1XcNRjM96nWaZFw7YAKnSMEQmDspL1ThO6mBY92c/DWIcH0BGPRX?=
 =?us-ascii?Q?xmZ6GL1ewTZGMQB7ySmOha/FxjZzP+otbVV1tscJx0oq69+0366V3e6x6hQ6?=
 =?us-ascii?Q?/zyMVArEyD/+LD2bN4HWQJooCQv43VH4NkQ87k6ZAw4YDzjffvltSwMxOjTg?=
 =?us-ascii?Q?W7cheNj3jVmv5SRZWGtFHkjBBhxrfF+UdCTF7AJ6Wkj60TjMnp40iF/Tq7De?=
 =?us-ascii?Q?0QUf7c6nQSi8AiEUUnAOpe7gmejXYnFRCurfoiqSJH8H9DfyIqHaBwx18MoB?=
 =?us-ascii?Q?A8ImY/F4tU6emZR+pioDPwrVypr2bXYUmJNmiK1nwZFy+GtFvOgopLn4u6AP?=
 =?us-ascii?Q?3jFWdqFiJFhNcv6H9r3oMa1/cf5uz8D7k5Ovo7smnKJwXJmGsFc9SshO8Yku?=
 =?us-ascii?Q?S567Djva73SnzrnXDTdrG7u5sIyVgcIRDV90BhvMfV0V6uTbgJ5nfn0Vh3vw?=
 =?us-ascii?Q?cBNCZs5RvS7BNm/uy8EEi/eJGUc3DtcYePhE=3D?=
X-Microsoft-Antispam-Message-Info: 6W0VkS8jZhHQbaI0qMyi19qpZd2UYxxbfltbcolNH91Fmuc8jjYy5erCrX7wCIY60D1c1C65CR9IxzeZefaoGsM1GDXGOBWGEPmqF4FHS1kHP/GVrNaUnHzEjBvg+NiNaAJAxol5LddeTIJZrMyuCuRS3leMIdh8mlFDcdH0moV12TVAOMxFhUeOllKGMJuM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0502MB3918;6:uTg12E24hP+x8378HKHFcjFIXldas5KaXx2vterjcybwLVsKk3LDsDr9wz0EtCKslmhKagyYsWHv2JqzHeC0y8HP17REXYPdziHS3ntD6pp3ptNVUq7PHi1cs9YfNrEOcd5f0mcXyOuqO0EA7VEZjYGBolXODpPHcpxBzsstt4KuaoOihCdQFTK181m8fHZgPoq6uErE71t+IkYgJmnwLDKKhLu/GmMdg/Po7oVULf3ItFCWdxWbAGOfuGHCtZzNgEBEe/PBGsSy0gHN/5uS612LLwHwVaCzfP5ksa7WMgnUYvT+M7NU9eLYzFi3v6zsH62BV8Al5pUqCvLh9lFFA8kDH08rLdLAtUmClbVEMuM=;5:4REFgeewR0G6BUW78ZNHnalkBAg6ZqsMHIlET2sYi1Lo5g3CAkWeW2JA2gp5Be5b5Z0IVgQFlV8akqOBgn+Vnpvl8k7A0/DFoEPrSFkFjdvtFTg/Wv28LlBprXpn3xvb7KuQZOu/W0+nF7mlV/kVD9ZmAR0ErO551YGEkq6meS4=;24:LuBseHh64NSLhX2Z6TsOxDN+Iyug0W1kyTPdqagPGaKQc5IYpAbjJyrcVROgyjkwrVLbPu3yI8KXPloG0YvXyb8cQR9BVQE1RHC+N/LzjUA=;7:AInP6BU/KI3I+RqFT3drCSgGDoXSeZr3y9YCgF7a9iNLNNlSCeOaJJDrLzlt/SHD29NyCiWF2qzJU9QEw/jleZ6/A6+Fw08IAaw2D3uiLzYk8lfzEEbxUhBGEupruZMzZA0y1ysQWIlkPHn0cFV50oeYAMBqQFTEwf81BBv1DUjqahxMTtWlxeDuHGCzg3ZPSpmeANehD+f1bcTtE1BLR8Jn5/mJLlp3+NmWLYWrv4FyZL4F6hfGhOkxxgUUS3LA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 14:29:05.6636
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ca1cc19-1f87-461b-16a3-08d59001445b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3918
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HtrkgkD3uBADSQLK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 22, 2018 at 02:36:55PM +0100, Dmitry Vyukov wrote:
> On Thu, Mar 22, 2018 at 2:20 PM, Leon Romanovsky <leonro@mellanox.com> wrote:
> > On Thu, Mar 22, 2018 at 02:10:21PM +0100, Dmitry Vyukov wrote:
> >> This bug is actively happening several times per day, if such bug is
> >> closed syzbot will open another bug on the next crash.
> >> This bug has a reproducer, why do you think it is invalid?
> >
> > I tried to reproduce it on latest rdma-next and failed, so wanted to
> > start from clean page and see if it is still relevant.
>
> Ah,  I see.
> You can now see the current status on dashboard:
> https://syzkaller.appspot.com/bug?id=d4ac7bfeafac8a3d6d06123e078462ac765415e7
> Yes, it still happens.
>
> syzbot has already reported another incarnation of this bug, you can
> see the link to dashboard in the email:
> https://syzkaller.appspot.com/bug?extid=b8d5eb964e412cfd2678
> and it contains a link to the first version with reproducer.
>
> > Does it still reproduce on latest rdma-next?
>
> syzbot does not test rdma-next.
>
> But can you reproduce it on upstream tree where syzbot hits it? Just
> to make sure, you have ODEBUG enabled, right?

Thanks for the tip, I added more debug options and returned to try the
repro on clean v4.16-rc1, it looks like I still don't have all needed
config options (SELinux).

  mount(selinuxfs) failed (errno 2)

Can you please cancel my email that closes this bug?

Thanks

--HtrkgkD3uBADSQLK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAlqzvawACgkQ5GN7iDZy
WKccUA/+LbBHJ0iMv/ogS7qC2Lc8Uflh7l/he/6nRHkQMoRtZzdTQyuY38tOrHtN
YKQH+TyA6wgmH7WVGMJG1qkHCo878i7RX4JyDBKzSgAabL2WGsG1f5ZBxp5u3DSE
sWws0IxRCRVde4VYhiBj+Az/WbtTXzz4vmua0q5dGNrIHGftReOu5nojw+hFCX4P
KPT7EOFSE7na7n9Qv1TJEuLFzu5fZiFXAS5aVIjJ+7axJwJ7gAArNML//lLW9d01
YJyM1eEXRWEAfKBJZEYylGEJTKG4jlzPJJdbPtTeVCERApDLUX9G0QG7vDqSHT+r
XEfS44e9XbrNjL6iyZYIU7CBukewKXxxHGLiWptOkAzOue/d5SGXRFryDea6JnZP
nYPV+xKwWD+tevax4WxjEKSe82s6hwyqou+Gs2Iv0YQUagjul7Weep/DGFryiir/
meGv/AxN5mbn2KNtKHwh7cZQkTKb7I5TnhW/bIR18RIN2gj6f6SQZsz+jMohI5Yn
pAqZtP54XjxBhBHybdOXJOP5eu7pOOP5IcHVjozENhhywliLZayGtWTv8D+N0PbJ
VQ3z9w3YfmadHyub/DLYP4b56m45Uf5xsnG4FkezMWL9ugou0wAi2DXdTWLWkRua
EzwC9RrP577dwCykxq1P/iGw3nk9GD+7wtHNeNVMAOsMP3w/728=
=sXbH
-----END PGP SIGNATURE-----

--HtrkgkD3uBADSQLK--
