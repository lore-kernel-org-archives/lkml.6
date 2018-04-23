Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753894AbeDWBdk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 21:33:40 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:56687 "EHLO
        prv3-mh.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753830AbeDWBdi (ORCPT
        <rfc822;groupwise-linux-kernel@vger.kernel.org:0:0>);
        Sun, 22 Apr 2018 21:33:38 -0400
Subject: Re: [lkp-robot] [btrfs] 7eafb77890:
 stderr.fs_mark:fsync_failed_Input/output_error
To: kernel test robot <xiaolong.ye@intel.com>
Cc: David Sterba <dsterba@suse.com>, LKML <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
References: <20180423012045.GL5563@yexl-desktop>
From: Qu Wenruo <wqu@suse.com>
Openpgp: preference=signencrypt
Autocrypt: addr=wqu@suse.com; prefer-encrypt=mutual; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWCnQUJCWYC
 bgAKCRDCPZHzoSX+qAR8B/94VAsSNygx1C6dhb1u1Wp1Jr/lfO7QIOK/nf1PF0VpYjTQ2au8
 ihf/RApTna31sVjBx3jzlmpy+lDoPdXwbI3Czx1PwDbdhAAjdRbvBmwM6cUWyqD+zjVm4RTG
 rFTPi3E7828YJ71Vpda2qghOYdnC45xCcjmHh8FwReLzsV2A6FtXsvd87bq6Iw2axOHVUax2
 FGSbardMsHrya1dC2jF2R6n0uxaIc1bWGweYsq0LXvLcvjWH+zDgzYCUB0cfb+6Ib/ipSCYp
 3i8BevMsTs62MOBmKz7til6Zdz0kkqDdSNOq8LgWGLOwUTqBh71+lqN2XBpTDu1eLZaNbxSI
 ilaVzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCWdWBrwIbDAUJA8JnAAAK
 CRDCPZHzoSX+qA3xB/4zS8zYh3Cbm3FllKz7+RKBw/ETBibFSKedQkbJzRlZhBc+XRwF61mi
 f0SXSdqKMbM1a98fEg8H5kV6GTo62BzvynVrf/FyT+zWbIVEuuZttMk2gWLIvbmWNyrQnzPl
 mnjK4AEvZGIt1pk+3+N/CMEfAZH5Aqnp0PaoytRZ/1vtMXNgMxlfNnb96giC3KMR6U0E+siA
 4V7biIoyNoaN33t8m5FwEwd2FQDG9dAXWhG13zcm9gnk63BN3wyCQR+X5+jsfBaS4dvNzvQv
 h8Uq/YGjCoV1ofKYh3WKMY8avjq25nlrhzD/Nto9jHp8niwr21K//pXVA81R2qaXqGbql+zo
Message-ID: <32f3326a-301c-d0e8-1961-cf22463b4b01@suse.com>
Date: Mon, 23 Apr 2018 09:33:17 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423012045.GL5563@yexl-desktop>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jNTvRvLluNbDf4G3gW8yKKitqG0ga3iTg"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jNTvRvLluNbDf4G3gW8yKKitqG0ga3iTg
Content-Type: multipart/mixed; boundary="Ab5dYLAXHxScmX6SEoJu4RRENNaUktoEv";
 protected-headers="v1"
From: Qu Wenruo <wqu@suse.com>
To: kernel test robot <xiaolong.ye@intel.com>
Cc: David Sterba <dsterba@suse.com>, LKML <linux-kernel@vger.kernel.org>,
 Stephen Rothwell <sfr@canb.auug.org.au>, lkp@01.org
Message-ID: <32f3326a-301c-d0e8-1961-cf22463b4b01@suse.com>
Subject: Re: [lkp-robot] [btrfs] 7eafb77890:
 stderr.fs_mark:fsync_failed_Input/output_error
References: <20180423012045.GL5563@yexl-desktop>
In-Reply-To: <20180423012045.GL5563@yexl-desktop>

--Ab5dYLAXHxScmX6SEoJu4RRENNaUktoEv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

The latest patch handles it by introducing new @super_num parameter and
different check timing.

Thanks,
Qu

On 2018=E5=B9=B404=E6=9C=8823=E6=97=A5 09:20, kernel test robot wrote:
>=20
> FYI, we noticed the following commit (built with gcc-7):
>=20
> commit: 7eafb77890ff459863e3bc772465cb641c14f754 ("btrfs: Do super bloc=
k verification before writing it to disk")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master=

>=20
> in testcase: fsmark
> with following parameters:
>=20
> 	iterations: 1x
> 	nr_threads: 1t
> 	disk: 1BRD_32G
> 	fs: btrfs
> 	fs2: nfsv4
> 	filesize: 4K
> 	test_size: 4G
> 	sync_method: fsyncBeforeClose
> 	nr_files_per_directory: 1fpd
> 	cpufreq_governor: performance
>=20
> test-description: The fsmark is a file system benchmark to test synchro=
nous write workloads, for example, mail servers workload.
> test-url: https://sourceforge.net/projects/fsmark/
>=20
>=20
> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz w=
ith 64G memory
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire lo=
g/backtrace):
>=20
>=20
>=20
> [  128.496659] ------------[ cut here ]------------
> [  128.502439] BTRFS: Transaction aborted (error -117)
> [  128.50[  128.521041] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_re=
solver nfsd auth_rpcgss dm_mod brd btrfs xor zstd_decompress zstd_compres=
s xxhash raid6_pq sd_mod sg intel_rapl sb_edac x86_pkg_temp_thermal intel=
_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmu=
l crc32c_intel mgag200 ghash_clmulni_intel snd_pcm ttm snd_timer pcbc drm=
_kms_helper ipmi_si mxm_wmi snd syscopyarea aesni_intel ipmi_devintf sysf=
illrect soundcore crypto_simd sysimgblt ahci fb_sys_fops glue_helper cryp=
td libahci drm ipmi_msghandler pcspkr libata shpchp wmi acpi_power_meter =
acpi_pad ip_tables
> [  128.581706] CPU: 21 PID: 1581 Comm: nfsd Not tainted 4.16.0-rc7-0017=
4-g7eafb77 #1
> [  128.590723] Hardware name: Intel Corporation S2600KPR/S2600KPR, BIOS=
 SE5C610.86B.01.01.0019.101220160604 10/12/2016
> [  128.602982] RIP: 0010:btrfs_sync_log+0x9c4/0xbe0 [btrfs]
> [  128.609603] RSP: 0018:ffffc90008903ad0 EFLAGS: 00010282
> [  128.616053] RAX: 0000000000000027 RBX: ffff881037f0c800 RCX: 0000000=
000000000
> [  128.624712] RDX: ffff88085f75ed00 RSI: ffff88085f756918 RDI: ffff880=
85f756918
> [  128.633366] RBP: ffffc90008903bb0 R08: 0000000000000807 R09: 0000000=
000aaaaaa
> [  128.641948] R10: ffffc90008903a00 R11: ffff88085a4c2ec0 R12: ffff881=
074934000
> [  128.650601] R13: 00000000ffffff8b R14: ffff88107a630000 R15: ffff881=
074933800
> [  128.659213] FS:  0000000000000000(0000) GS:ffff88085f740000(0000) kn=
lGS:0000000000000000
> [  128.668879] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  128.675904] CR2: 00007f4a6a747660 CR3: 000000107f20a001 CR4: 0000000=
0003606e0
> [  128.684570] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> [  128.693185] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> [  128.701795] Call Trace:
> [  128.705166]  ? btrfs_sync_file+0x2f3/0x3f0 [btrfs]
> [  128.711151]  btrfs_sync_file+0x2f3/0x3f0 [btrfs]
> [  128.716910]  btrfs_file_write_iter+0x440/0x550 [btrfs]
> [  128.723284]  do_iter_readv_writev+0x116/0x170
> [  128.728753]  do_iter_write+0x80/0x190
> [  128.733487]  nfsd_vfs_write+0xaf/0x370 [nfsd]
> [  128.738885]  nfsd4_write+0x179/0x1c0 [nfsd]
> [  128.744121]  nfsd4_proc_compound+0x3f1/0x640 [nfsd]
> [  128.750123]  nfsd_dispatch+0xf5/0x230 [nfsd]
> [  128.755499]  svc_process_common+0x496/0x680
> [  128.760732]  ? nfsd_destroy+0x60/0x60 [nfsd]
> [  128.765996]  svc_process+0xed/0x1b0
> [  128.770499]  nfsd+0xf1/0x160 [nfsd]
> [  128.774899]  kthread+0x11e/0x140
> [  128.778988]  ? kthread_associate_blkcg+0xb0/0xb0
> [  128.784679]  ret_from_fork+0x35/0x40
> [  128.789187] Code: 00 00 48 8b 42 50 f0 48 0f ba a8 e8 cd 00 00 02 72=
 1b 41 83 fd fb 0f 84 6f 01 00 00 44 89 ee 48 c7 c7 40 ec 76 a0 e8 3c f1 =
95 e0 <0f> 0b 48 8b bd 60 ff ff ff 44 89 e9 ba 1d 0c 00 00 48 c7 c6 20=20
> [  128.811411] ---[ end trace 6c998d6c6547e8f7 ]---
> [  128.817132] BTRFS: error (device ram0) in btrfs_sync_log:3101: errno=
=3D-117 unknown
> [  128.826014] BTRFS info (device ram0): forced readonly
> [  128.835886] fs_mark: fsync failed Input/output error
>=20
> 2018-04-19 17:23:24 fs_mark -d /nfs/ram0/1 -D 1000000 -N 1 -n 1000000 -=
L 1 -S 1 -s 4096
>=20
> #  fs_mark  -d  /nfs/ram0/1  -D  1000000  -N  1  -n  1000000  -L  1  -S=
  1  -s  4096=20
> #	Version 3.3, 1 thread(s) starting at Thu Apr 19 17:23:25 2018
> #	Sync method: INBAND FSYNC: fsync() per file in write loop.
> #	Directories:  Round Robin between directories across 1000000 subdirec=
tories with 1 files per subdirectory.
> #	File names: 40 bytes long, (16 initial bytes of time stamp with 24 ra=
ndom bytes at end of name)
> #	Files info: size 4096 bytes, written with an IO size of 16384 bytes p=
er write
> #	App overhead is time in microseconds spent in the test not doing file=
 writing related system calls.
>=20
> FSUse%        Count         Size    Files/sec     App Overhead
>=20
>=20
>=20
> To reproduce:
>=20
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
>=20
>=20
>=20
> Thanks,
> Xiaolong
>=20


--Ab5dYLAXHxScmX6SEoJu4RRENNaUktoEv--

--jNTvRvLluNbDf4G3gW8yKKitqG0ga3iTg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEELd9y5aWlW6idqkLhwj2R86El/qgFAlrdN94ACgkQwj2R86El
/qjx/wgAnyL+OloFPQnsLMl31sM8C3ZKGa45qXNFoSqQH/ga6CDXhLYwgT5jAxRX
2EdmBYPrXyPMmyoOixs1pVBsh7YqYUd39ROaZqVyoaEhWxrcsx6r5GUZAM6jb4Mx
0QGz1kXHX8JgJAT0lpAhLE0XYLyR6mw8Ae+oLQKrefi5H8w+F/BBgwQ+bOfEiP02
t5VfIo75S6f7Knd7Vu/k0ZulVDuj/QRk1IIzM7M/GpAOu7v/cRj0r9I0c5YHVD9g
Im3IWhTGuaP5ypkh0Lm58Gf96Z+u0HIPtvikkq4w4wGGNntv6QypLjBlBuD0ofa2
J84s73fVIHxx+kdsY/hwExYRy1cGBQ==
=cSgP
-----END PGP SIGNATURE-----

--jNTvRvLluNbDf4G3gW8yKKitqG0ga3iTg--
