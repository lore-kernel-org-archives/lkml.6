Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755055AbeCVPON (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:14:13 -0400
Received: from mail-db5eur01on0081.outbound.protection.outlook.com ([104.47.2.81]:5604
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754942AbeCVPOI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:14:08 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=leonro@mellanox.com;
Date: Thu, 22 Mar 2018 17:13:58 +0200
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
Message-ID: <20180322151358.GE19440@mtr-leonro.local>
References: <94eb2c0bc3aa8b2432056623c735@google.com>
 <20180322124823.GB19440@mtr-leonro.local>
 <CACT4Y+Ya8iMgV=7YGgsO2XnusF9tnGcHHPF5U5oNjQz_eJ+vMw@mail.gmail.com>
 <20180322132031.GC19440@mtr-leonro.local>
 <CACT4Y+a2KB6vvgFcqkq7cMCiCZQEFNxsCTgP+_gtgju8H2q9hQ@mail.gmail.com>
 <20180322142900.GD19440@mtr-leonro.local>
 <CACT4Y+ZEGHp9vg68O7dDfRWj+_bKZQCGQX2AcFckm8GBYaREug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ScBGguMCFzdFq7Io"
Content-Disposition: inline
In-Reply-To: <CACT4Y+ZEGHp9vg68O7dDfRWj+_bKZQCGQX2AcFckm8GBYaREug@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: LO2P265CA0144.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::36) To AM0PR0502MB3908.eurprd05.prod.outlook.com
 (2603:10a6:208:20::26)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 33a92dc5-de85-41c2-5000-08d590078d0f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:AM0PR0502MB3908;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0502MB3908;3:XIKDela/GAZjkKER0Y98NJhYYhz7vMvypsqSsj7IDIrsfav+JP24EgKMD9pHqNNfcJnqPjNWF5qxcxEr5J8LbDnM1skikIgmX35teGurGXsSE+od96q7TpX3ZjEHsqDW+LvoQjWjuJnBNbexOWWRvnPcKjV4OhN4SP9sVhh1NVOIVZAprv+nlRThsotTdwDfKPHM78FLAP/9c/Oeo+/v6m1FjTzt9E7YQFP0qDiQ/uJiYKbJtwCqILOkkf9Dqrci;25:QnPVsbqz1O1FMAm3DRzjQUYtQaL3tRVKIyU9NcnglVQA0830sUAD1J2L01wMbc7UPoI7ELJ86MZfUTVFvxT4PTrOSEwzI4lwytLGE8D6YLtCB48hnvM8Pu6yFrLdBYJ1gd19+Z29nwAUxAeOoF9Wqg81hQgZ1QLrDehVtGsbhNw9VRaL6cktqlrOuLbVeOZGrVPiCiwJGAIRHryxzQIvmmbObrmCc7SIv6oUC3UL5stjWltPDZXgqlJn4vppJsiTrZfZPaBfVCsyaGEOzig7Rst0V85xbjuYgT5lFZ89f9Wd8h3zDgwmgPlYm6rPlKRZBl2fqiySQpiLW+bhwmbzzg==;31:uL30NOReh6ULQHnEdvn89wxQTwNy5//c1lXANBg4mtJi0Hlv7uN4HZ8XDjElGiSe7pqw8rc282FfOwaGepMjEoYrETfd8vniswiJIHaNnqHEcB6xIVfAcwUsSOb1uoCC/MtKdqlDEJWgcJ7slz2B5wyOr98AQ8hFGefLqbAup/vvu7HFhz8p+pTJrPaDMSZBq6iGE2k1vh7tofHPJ+wtFypZHQjme6dXq5Ehr8csBdI=
X-MS-TrafficTypeDiagnostic: AM0PR0502MB3908:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0502MB3908;20:vRXwNk4uK0b2q4d1GrNWiz/e62DOFzBi+Mf9XRv3F76eFh6nvGO+zg76hFXn5OKRXgOUtF0Y3N/9tpnoBmDbGXnXPPD64MbGcFBI2ohVYaMiGdeSpRn8T6cId+g9b/LuSgMbw+cV8xIrup1YpJunnD/ApVubjRj+kvVxIRcyESYSdtPM0MLTHPurWbjtGOzwwqygn2XSTmO49nq7YtSiNxvDpNQqXQf74C5P39ViRixyIXto/02deYQE1hgjYl/92voUr0NCoEcgec0hdhccsrnteqJWg7BPymh5JiiPNcyYbrRpr1UmgxYTCNxiqmt8/TOjhiu66RTGVqevQJKd0UL+EaJipn2yfazXkxuQS30p5CNJ43tP5WRXgN7ZYdXLvMHUEM3EEndF92FXHtdiF027MPFC/hjVDK7zcHYr04gJ/D2tEZtyS6QgcuNrP+DC/nz5h8afzWAAO177SZ+qh45Dyva26iexWEMphNdQshjbXwjZJWUwd+D6jOStoQia;4:nKnPBqbglw8La/3gF+p84UKkZ7i54ZH1ZNPu5IJ7k/ySDp1pbDgauVgkCOkY7w1tIM+fUHXnIGagAxf8PTGnsx9z2GxoRlrFrg7eGn7TNIbkf4tfbTHlGt4kJzkuH0AE3bQbPe0WpbHytaFi0oQc1bIvZekyBQdwrw4SH3GVAUjrMs7RywC8oTHJ5ovNqQmWpXhHjR+wiryZv7j+Fen+V0wmqjY7jDKateSFibsvVswTsGDsLYSsGbkNQZ4GCE8jAbfs+71LvA9oLshtnGszjA==
X-Microsoft-Antispam-PRVS: <AM0PR0502MB3908AE5844AF1D9D109D4069B0A90@AM0PR0502MB3908.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(10201501046)(3002001)(6055026)(6041310)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:AM0PR0502MB3908;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0502MB3908;
X-Forefront-PRVS: 0619D53754
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(39380400002)(39860400002)(346002)(376002)(396003)(366004)(51914003)(45074003)(199004)(189003)(98436002)(6496006)(84326002)(86362001)(8936002)(52116002)(81166006)(97736004)(2906002)(81156014)(8676002)(76176011)(7416002)(4326008)(26005)(316002)(6116002)(16586007)(6666003)(446003)(6916009)(53546011)(1076002)(2950100002)(3846002)(63394003)(58126008)(25786009)(105586002)(305945005)(33656002)(386003)(7736002)(106356001)(44144004)(33896004)(229853002)(186003)(16526019)(76506005)(54906003)(6486002)(66066001)(21480400003)(966005)(6306002)(53936002)(478600001)(9686003)(68736007)(6246003)(5660300001)(93886005)(18370500001)(99710200001)(2700100001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0502MB3908;H:localhost;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;AM0PR0502MB3908;23:12JIVubCvulEj/Z+9t8Qp4d3uVzx4Gpl4pZ6vlI?=
 =?us-ascii?Q?qBvq66QQUTWDJST2OPov603PGTIFCRuC0My1GpoWczO5cWH54YEByIEfqb5x?=
 =?us-ascii?Q?0ZNh9fnI1x4T2G1OPyeT+Qb/1Mlw2TueBKQpUaQrlmKakkSiQLdPvgcevkYp?=
 =?us-ascii?Q?s6dlk4hJZ9lCaEYBs7H1QkXAaup3SbFl947Lg6O3/oNdBKFDokdLXk37lp2Q?=
 =?us-ascii?Q?yibTK29Oean9F7gcKx00OfzwwIYXQtle5KNuwFqua9eKt8in8whBhCi6Lggf?=
 =?us-ascii?Q?bl7t48I2ATfaxU7NdAgKHzZFarPM/EIXPmHwTfohSsTo1rgruHwZEdGyznyG?=
 =?us-ascii?Q?8taCXgcQ6VyTByAvKGPyNI42HewSBZRHnCTCio5HrxhMfkcwZey9zH4o9zYq?=
 =?us-ascii?Q?JvW8t5DuenT4xJmZKDtrpcUxB+DXYbD4YvM51eUcjW9EPjzXJD6C08+kuJ6m?=
 =?us-ascii?Q?3k38oFnF7tSed/r0ezYGAc/Mgp+EcADT1NdIoo1aWN0ovt1ma8I1Quj74a/8?=
 =?us-ascii?Q?hmrhQRShYqFhRT2ryBAkMswWfwoff88jdYhY8NBXMcwkVqT73xYxP1e5WSOz?=
 =?us-ascii?Q?ztvT3WOhaojq8foPNqraviEzU0+hwsJf+PTlexdrp6Rtm4tukraG4bJRVWTA?=
 =?us-ascii?Q?1EpSamhfSdwXiO7KPXSYnyhkn/HMVRipUqTs4TmLtifwfmACalawOvhCuQ+b?=
 =?us-ascii?Q?CvuK0RLhmicr8zHoSXUb38QDweVMb0pUapRU7uCHOrhNEMja3bySUi27Ws7x?=
 =?us-ascii?Q?4yZuV/tqEy5NyaRW8HrTvFC3RUbVngfVIerVisS2ZqO2SuU9jZYLhvLuXYSI?=
 =?us-ascii?Q?xiVN+AGDzFvLiG/waogxwEW32qrbXMxLd7lEf0tXGe5MUtxgtWxYfx7YB60k?=
 =?us-ascii?Q?3xR1siWuE9O7O57kKfXyQ5yBKUy1ePHy95LMwinJith7tbkJTcGpE/g+J6mM?=
 =?us-ascii?Q?6Ma5+vj76cbXrSPliYWg1sPTdSAfuFVwxWdNP+yKx5k/MzNyOrF1jl4GtO4f?=
 =?us-ascii?Q?GpY70vXCqIg70AASxT1SQGGPc7X+vDIUZjXSICtSxSS1SuKCcljb/0ftilDP?=
 =?us-ascii?Q?+GsTo/pBbKIG6UrQvMKkQCDPYhShFK5B+DYCLsykSwoATm73I7ZABfSc/MJC?=
 =?us-ascii?Q?XhyxMI/dzI2UUsxxgIG9a0BROMpjfOIt0mJSFonWnxbP3v63FPb1+QSVR+Df?=
 =?us-ascii?Q?2B4QJXc/OP8MstDp7wqbH6yeBAlyXovPNHTMXrSsUCzKNdFwOxbI7+FBM6VG?=
 =?us-ascii?Q?jb3FvztCc59qGTTxNKcNavrQeCje48/taCJBdzjVWoehb978HGgsSo0XnQgl?=
 =?us-ascii?Q?JbmnjALzVZ+kQvlgkTKMvGAC8UM1jZH1/SVStoRCwR+Aog+iKPKQDRUYIK11?=
 =?us-ascii?Q?cxFOg2H+JeZfz5rVmYNtI3KsvuYY5hDT9XY8knX28dQdEudOsmtTwY/oRoxL?=
 =?us-ascii?Q?NUWzj6hKI7/2PluckV2tFZ+Aui+yn99oB2OFgWeW+IrxvfscUWf5qsoJsqBh?=
 =?us-ascii?Q?bs/SCbSo5XkZyZvtsrwL1XFD1qGCRb09Ylpg=3D?=
X-Microsoft-Antispam-Message-Info: CuNh9/hucbgOM9Ns1sCBmOj97HosAtUUatOJ3+N6K6M4TSXMoy4avbvpAxztifqJZaYKxSH4l2MTASXeanGBj5N45NgB70cxifhoK9RmsXfdLqHRzdLdzVDzkCDVNo1YHMoxbVtFUakqYDKOzAtKTUThRoRLiSiE/2fDDkDrFuwKcxdEuAE/r6oxnKpLG6jk
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0502MB3908;6:YIpMMRMbiGUF7kWgylV/2s0QbWnODm26CTuam8p4f5OX1MtfoQIs4cnNuACWXgqIWtpUCbxUHjQPNxYnJUC55nFHy33jwN0fwSuMog6YOEatO8vJ5Gopa5MKpOm7Ih2b9X12Km90tV+H/u3556X/AojWWm0I7w9nfaGKnfwfQbDk65+Lr2ipH8akTCffjyU5KM1c7ETSkxyrjN7mBVuN9E9os1X7pEuN0vUXk1nyZFMi7nautWJeaeOkXPFb/m7yBJIJlYaHemWpdYd/9HUxQ9ZNdXP7KDSt0JZ+axczIAwuxBP7X2vI12KcP9JTEdiSxFwMT++9c9OFhEBt70xn9bM9AugF5eLpZ806kd8wxAbuV8svFJsvwUfv8v624bCXgRaX7QlhOIK18WOakA8jmzjsjnlW1bBoJy3c0pNqKxWDAighmY2bOlu+PhhAKhAe8vK1q4ctQjzeDSP5tZzwaQ==;5:n9xslBej6V2+9vopJF7FdDQjtCDyMtr4Cgxv6tAKUEfGQS6m0vrogcvwZrveqECrZOdGKbis3LBOVR0y3InDeSyAkWjPAvskLijsLe+ay/PlcQbZzCMWK6YQLQzKSF3Xx+6J/BJKmY41qn7QqGyTu5jL4NunxCT/RXdlZ3+OcFI=;24:MU06oCw8YRgi45ZewNlX+tpOqaRtr4IFIGrYGF0/8FOJ7iQMjcMsApL30o92Gao+phXwoHDEB4DMWkynDoDTZhpMbD1B8bsrMz9je5Evni4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0502MB3908;7:JvU2EfbCDAHTcc6m++/WUSKSulbMwPrLyjHQDgiape6lw5AAf+nupzRbnDsukSm24JZJrncOTt90vhYLHzQ56B3NBFhq2LHf0HJ+8b/d/CcJIZepZu9SJ+y0JM2sIjo0szlfnzdvjuohKnaYYfHAzyTSH5JQWXdz4Hb7Ks0rJurWpAn52azXUepzeujxvAHoW0uWaZeU52EI0DyvZW0GBtmVP1g9wwgt1s3V0cg0z7yaYMC+ixzvR64GNic8M9wr
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2018 15:14:04.6836
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a92dc5-de85-41c2-5000-08d590078d0f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0502MB3908
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ScBGguMCFzdFq7Io
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 22, 2018 at 03:47:41PM +0100, Dmitry Vyukov wrote:
> On Thu, Mar 22, 2018 at 3:29 PM, Leon Romanovsky <leonro@mellanox.com> wrote:
> > On Thu, Mar 22, 2018 at 02:36:55PM +0100, Dmitry Vyukov wrote:
> >> On Thu, Mar 22, 2018 at 2:20 PM, Leon Romanovsky <leonro@mellanox.com> wrote:
> >> > On Thu, Mar 22, 2018 at 02:10:21PM +0100, Dmitry Vyukov wrote:
> >> >> This bug is actively happening several times per day, if such bug is
> >> >> closed syzbot will open another bug on the next crash.
> >> >> This bug has a reproducer, why do you think it is invalid?
> >> >
> >> > I tried to reproduce it on latest rdma-next and failed, so wanted to
> >> > start from clean page and see if it is still relevant.
> >>
> >> Ah,  I see.
> >> You can now see the current status on dashboard:
> >> https://syzkaller.appspot.com/bug?id=d4ac7bfeafac8a3d6d06123e078462ac765415e7
> >> Yes, it still happens.
> >>
> >> syzbot has already reported another incarnation of this bug, you can
> >> see the link to dashboard in the email:
> >> https://syzkaller.appspot.com/bug?extid=b8d5eb964e412cfd2678
> >> and it contains a link to the first version with reproducer.
> >>
> >> > Does it still reproduce on latest rdma-next?
> >>
> >> syzbot does not test rdma-next.
> >>
> >> But can you reproduce it on upstream tree where syzbot hits it? Just
> >> to make sure, you have ODEBUG enabled, right?
> >
> > Thanks for the tip, I added more debug options and returned to try the
> > repro on clean v4.16-rc1, it looks like I still don't have all needed
> > config options (SELinux).
> >
> >   mount(selinuxfs) failed (errno 2)
>
>
> It seems that you have old syzkaller sources, it now explicitly does
> not fail on ENOENT:
>
>     // selinux mount used to be at /selinux, but then moved to /sys/fs/selinux.
>     const char* selinux_path = "./syz-tmp/newroot/selinux";
>     if (mount("/selinux", selinux_path, NULL, mount_flags, NULL)) {
>         if (errno != ENOENT)
>             fail("mount(/selinux) failed");
>         if (mount("/sys/fs/selinux", selinux_path, NULL, mount_flags,
> NULL) && errno != ENOENT)
>             fail("mount(/sys/fs/selinux) failed");
>     }
>
>
> > Can you please cancel my email that closes this bug?
>
> There is no such option. The new bug is already created:
> https://syzkaller.appspot.com/bug?id=6ecd3fdba0501c8843300056375abea0880816d2
> now if we open the old one, we now have 2 for the same root cause. It
> will lead to mess.

Still no luck, I'll leave this bug for now.

Thanks

--ScBGguMCFzdFq7Io
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEkhr/r4Op1/04yqaB5GN7iDZyWKcFAlqzyDYACgkQ5GN7iDZy
WKcd3Q//cAEhAHVAtQFkl1E6IV9AFpUi3L3h6dHB/Qtbth2IFtd5BX6pYmoAufsw
pSmXwiegc28LerIKc+A7B/uaLiJgVwVkBuagwHcAQwkvLQaGgXlYszF/wtHmXSL+
9fsRh4wCsuwYKlwlGDSCMGE74F+XLxAhOcWSw5hQ57/wwr8e6cErWHVngCGS4p54
5vxODfJsjdszk1hgpvws79aSQ9/vD0OS+z/CKu7900XcOP1cTFmaRQzbbd0L0BpR
2sF7x37CJG9V1mBOLfS0uwsyswrJhGBdV4UT6nyml1X4yvQ7iENnciCRxkR8V0Wm
kK2dj98/WyXKuZHiNTpQs4beAKULntvcx1P1ts8cuwqPXLqLT24Pva6iekLu8ibY
Siv7iFgRRYMMjtIljkPJ0jvaR0q8Tj32O5U2bbkVUpw/5aedD1rhaLbEEUGy7s+c
4pbYNn3RRDaCt/dhvpzkUs3er7yTnpu0/ApII9H589tb6oWrl2w2i2kJ0/KrkZ5Q
sGTPwktQROBVkEenBTi1T37Y/nHKO8iLhOr8UIS7CzV7e2iwnyuT3wSc//FMS7zU
dPBnFDhXSvb/EECMHBJG+ZDFlwnrMsdtsV5GwFq+BPJWEH6oq1KLfexqqMMJSAHP
BbJoXLWiL+D/d1Z6dL9ivRirUcZ5VNaAI7KJ/77XOQ3ZRG/eszU=
=CmuX
-----END PGP SIGNATURE-----

--ScBGguMCFzdFq7Io--
